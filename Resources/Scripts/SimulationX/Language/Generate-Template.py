#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Copyright (C) 2019, ESI ITI GmbH
All rights reserved.

Generate POT file for Modelica library localization:
python Generate-Template.py package_name
'''

import codecs
import datetime
import logging
import sys
import types
import threading
import pythoncom
from win32com.client import Dispatch, GetActiveObject, pywintypes

from SimXEnums import *

logging.basicConfig(level = logging.DEBUG, format = '%(message)s')

class SimXPackage(object):
    def __init__(self, package_name):
        self._sim = None  # SimulationX application
        self._package_name = package_name
        self._items = []
        self._annotations = frozenset(['Documentation.info', 'Documentation.revisions', 'obsolete', 'missingInnerMessage', 'unassignedMessage'])

        dispatch = 'ESI.SimulationX41'

        try:
            # Open SimulationX
            try:
                self._sim = GetActiveObject(dispatch)
            except:
                self._sim = Dispatch(dispatch)

            # Show SimulationX window
            self._sim.Visible = True

            # Wait till SimulationX is initialized
            if self._sim.InitState == simUninitialized:
                while self._sim.InitState != simInitBase:
                    sleep(0.1)

            # SimulationX in non-interactive mode
            self._sim.Interactive = False

            # Load libraries
            if self._sim.InitState == simInitBase:
                self._sim.InitSimEnvironment()
            
            pkg = self._sim.Lookup(package_name)
            if pkg is not None:
                self._fill_data(pkg, package_name)
            else:
                logging.error('Package ' + package_name + ' not found.')
        except pywintypes.com_error as error:
            logging.error('SimulationX: COM error.')
        except:
            print('SimulationX: Unhandled exception.')
            import traceback
            logging.error(traceback.format_exc())

        finally:
            try:
                if self._sim is not None:
                    self._sim.Interactive = True
            except:
                pass

    def __enter__(self):
        return self

    def __exit__(self, _type, _value, _traceback):
        if self._sim is not None:
            self._sim.Interactive = True

    def _fill_data(self, pObject, scope):
        description = pObject.Comment
        if (description):
            self._items.append((scope, description))

        if pObject.Kind == simType:
            for pChild in pObject.Children:
                logging.debug(pChild.Ident)
                self._fill_data(pChild, pChild.Ident if pChild.Kind == simType else scope)
            for annotation in self._annotations:
                anno_value = pObject.Execute('GetAnnotation', [annotation])
                if anno_value and anno_value[0]:
                    self._items.append((scope, anno_value[0].strip('"')))

    def export_pot(self):
        header = r'''# SOME DESCRIPTIVE TITLE.
# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
# This file is distributed under the same license as the PACKAGE package.
# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
#
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: PACKAGE VERSION\n"
"Report-Msgid-Bugs-To: \n"
"POT-Creation-Date: {0}\n"
"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language-Team: LANGUAGE <LL@li.org>\n"
"Language: \n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"
'''
        now = datetime.datetime.utcnow()
        content = [header.format(now.strftime("%Y-%m-%d %H:%M+0000"))]
        msg = '''
msgctxt "{0}"
msgid "{1}"
msgstr ""
'''
        for ctxt, id in frozenset(self._items):
            id = id.replace('\r\n', '\n')
            id = id.replace('\n', '\\n"\n"')
            content.append(msg.format(ctxt, id))

        with codecs.open(self._package_name + '.pot', 'w', 'utf-8') as f:
            f.write(''.join(content))

class Worker(threading.Thread):
    def __init__(self, package_name):
        threading.Thread.__init__(self)
        self._package_name = package_name

    def run(self):
        try:
            pythoncom.CoInitialize()
            with SimXPackage(self._package_name) as package:
                package.export_pot()
        except:
            print('SimulationX: Unhandled exception.')
            import traceback
            print(traceback.format_exc())
        finally:
            pythoncom.CoUninitialize()

def main(package_name):
    # Start new thread where CoInitialize() and CoUninitialize() can be called in pairs
    thread = Worker(package_name)
    thread.start()
    thread.join()

if __name__ == '__main__':
    if len(sys.argv) == 1:
        package_name = 'TranslationTest'
    elif len(sys.argv) > 1:
        package_name = sys.argv[1]

    main(package_name)
