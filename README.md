# TranslationTest
Modelica library for gettext evaluation

## Library description
This is a Modelica library only created for [gettext](https://www.gnu.org/software/gettext/manual/gettext.html) evaluation as proof of concept for the Modelica specification issue [#302](https://github.com/modelica/ModelicaSpecification/issues/302).

The POT file [TranslationTest.pot](TranslationTest/Resources/Language/TranslationTest.pot) (Portable Object Template) was created by the command

`xgettext --language=EmacsLisp --sort-output --extract-all --from-code=UTF-8 --output=TranslationTest.pot TranslationTest.mo`

The TranslationTest.pot file serves as translation template and contains the extracted original strings as _msgid_ together with an empty string _msgstr_, for example

> #: TranslationTest.mo:34  
> msgid "Contact info"  
> msgstr ""  

Afterwards, the required _msgctxt_ field was manually added for each recognized string, for example

> #: TranslationTest.mo:34  
> msgctxt "TranslationTest.UsersGuide.Contact"  
> msgid "Contact info"  
> msgstr ""  

Certainly, the string extraction based on the EmacsLisp language can only be considered as proof of concept, since there is no Modelica language available in xgettext. It is recommended to create the POT file directly from the Modelica tool, like e.g., demonstrated by Wolfram SystemModeler.

The PO file [TranslationTest.de.po](TranslationTest/Resources/Language/TranslationTest.de.po) (Portable Object) was created in [Poedit](https://poedit.net/), but could also be created using the gettext tools by command

`msginit --input=TranslationTest.pot --locale=de_DE --output=TranslationTest.de.po`

These PO files can be created for any supported language. It is highly recommended that these PO files are stored as UTF-8 and that this is respected by `charset=UTF-8` in the meta information of the file.

The actual translation work was done in Poedit again.

If the original Modelica file TranslationTest.mo changes, the translation process needs to be iterated again, by creating an updated TranslationTest.pot and merging it with the already available translation files by command

`msgmerge --update TranslationTest.de.po TranslationTest.pot`

The freely available C++ library [spirit-po](https://github.com/cbeck88/spirit-po) was used as PO file reader in SimulationX. It supports UTF-8 encoded files only and is available under the BSL 1.0, a permissive OSI approved license.

## License
This software is provided under a Simplified BSD license. See the [LICENSE](LICENSE) file for details on the license.
