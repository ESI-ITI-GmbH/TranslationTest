// CP: 65001
/* TranslationTest.mo - Modelica library for gettext evaluation
 *
 * Copyright (C) 2018-2019, ESI ITI GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
within ;
package TranslationTest "Modelica library for
gettext evaluation"
  package UsersGuide "User's Guide - This is a description
  with line
     breaks and leading spaces ignored by Dymola"
    extends Modelica.Icons.Information;
    class Contact "Contact info"
      extends Modelica.Icons.Contact;
      annotation(Documentation(info="<html><p>This TranslationTest library is created at ESI ITI GmbH.</p></html>"));
    end Contact;
    class References "References - with Hebrew characters: עִבְרִית"
      extends Modelica.Icons.References;
      annotation(Documentation(info="<html><p>See <a href=\"https://simulationx.com\">here</a>&nbsp;-&nbsp;SimulationX</ul></html>"));
    end References;
    class License "BSD-3-License - aka as \"Simplified\" BSD License"
      extends Modelica.Icons.Information;
      annotation(Documentation(info="<html>
  <p>Copyright (C) 2018-2019, ESI ITI GmbH<br>All rights reserved.</p>
  <p>Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:</p>
    <p>1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.</p>
    <p>2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.</p><p>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
</html>"));
    end License;
    annotation(DocumentationClass=true,
      Documentation(info="<html><p>Library <strong>TranslationTest</strong> is a test library for <a href=\"https://www.gnu.org/software/gettext/manual/gettext.html\">gettext</a>.</p></html>"));
  end UsersGuide;

  model CSVFile "Read data values from CSV file"
    parameter String fileName="csvfile" "File where my test data is stored"
      annotation(Dialog(
        groupImage="modelica://Modelica/Resources/Images/Electrical/Analog/Basic/M_Transformer-eq.png",
        tab="Parameters",
        group="File settings",
        loadSelector(filter="Comma-separated values files (*.csv);;Text files (*.txt)",
        caption="Open file")));
    parameter String delimiter="," "Column delimiter character" annotation(choices(
      choice=" " "Blank",
      choice="," "Comma",
      choice="\t" "Horizontal tabulator",
      choice=";" "Semicolon"));
    parameter String quotation="\"" "Quotation character" annotation(choices(
      choice="\"" "Double quotation mark",
      choice="'" "Single quotation mark"));
    public
      Real x;
      Real c "Contact";
    equation
      // Line comment with "string" and \"escaped string\"
      x = 1 "Equation description";
      /*
       * Block comment with "another string" and \"another escaped string\"
      */
      c = x "Contact";
      Modelica.Utilities.Streams.print("c = " + String(c));
    annotation(
      Documentation(info="<html><p>Test model.</p></html>"),
      defaultComponentName="csvfile",
      defaultComponentPrefixes="inner",
      missingInnerMessage="No \"csvfile\" component is defined, please drag TranslationTest.CSVFile to the model top level",
      obsolete="This model is of no use at all",
      Icon(graphics={
        Text(lineColor={0,0,255},extent={{-85,-10},{85,-55}},textString=DynamicSelect("csv", if delimiter == " " then "c s v" elseif delimiter == "," then "c,s,v" elseif delimiter == "\t" then "c\\ts\\tv" elseif delimiter == ";" then "c;s;v" else "csv")),
        Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
  end CSVFile;

  model SpecialFile
    extends CSVFile;
    parameter Real myElement = 1 "Component comment";
  end SpecialFile;

  model QuotationMarksInAnnotation
    parameter Real q annotation(Dialog(
      group="I'm an annotation value with \"quotation marks\" in the middle",
      tab="I'm an annotation value with trailing \"quotation mark\""
    ));
  end QuotationMarksInAnnotation;

  model TestContainer "Contact"
    CSVFile csv_file;
    SpecialFile special_file;
    QuotationMarksInAnnotation quotation_marks;
  end TestContainer;

annotation(version="1.0.0-beta.2", uses(Modelica(version="3.2.3")), Documentation(revisions="<html>
<p>v1.0.0 - March 2019</p>
</html>", info="<html>
<p>This is a Modelica library only created for <a href=\"https://www.gnu.org/software/gettext/manual/gettext.html\">gettext</a> evaluation as proof of concept for the Modelica specification issue <a href=\"https://github.com/modelica/ModelicaSpecification/issues/302\">#302</a>.</p>
<p>The POT file <a href=\"modelica://TranslationTest/Resources/Language/TranslationTest.pot\">TranslationTest.pot</a> (Portable Object Template) was created by the command<p>
<p><code>xgettext --language=EmacsLisp --sort-output --extract-all --from-code=UTF-8 --output=TranslationTest.pot TranslationTest.mo</code></p>
<p>The TranslationTest.pot file serves as translation template and contains the extracted original strings as <em>msgid</em> together with an empty string <em>msgstr</em>, for example</p>
<blockquote><pre>
#: TranslationTest.mo:34
msgid \"Contact info\"
msgstr \"\"
</pre></blockquote>
<p>Afterwards, the required <em>msgctxt</em> field was manually added for each recognized string, for example</p>
<blockquote><pre>
#: TranslationTest.mo:34
msgctxt \"TranslationTest.UsersGuide.Contact\"
msgid \"Contact info\"
msgstr \"\"
</pre></blockquote>
<p>Certainly, the string extraction based on the EmacsLisp language can only be considered as proof of concept, since there is no Modelica language available in xgettext. It is recommended to create the POT file directly from the Modelica tool, like e.g., demonstrated by Wolfram SystemModeler.</p>
<p>The PO file <a href=\"modelica://TranslationTest/Resources/Language/TranslationTest.de.po\">TranslationTest.de.po</a> (Portable Object) was created in <a href=\"https://poedit.net/\">Poedit</a>, but could also be created using the gettext tools by command</p>
<p><code>msginit --input=TranslationTest.pot --locale=de_DE --output=TranslationTest.de.po</code></p>
<p>These PO files can be created for any supported language. It is highly recommended that these PO files are stored as UTF-8 and that this is respected by <code>charset=UTF-8</code> in the meta information of the file.</p>
<p>The actual translation work was done in Poedit again.</p>
<p>If the original Modelica file TranslationTest.mo changes, the translation process needs to be iterated again, by creating an updated TranslationTest.pot and merging it with the already available translation files by command</p>
<p><code>msgmerge --update TranslationTest.de.po TranslationTest.pot</code></p>
<p>The freely available C++ library <a href=\"https://github.com/cbeck88/spirit-po\">spirit-po</a> was used as PO file reader in SimulationX. It supports UTF-8 encoded files only and is available under the BSL 1.0, a permissive OSI approved license.</p>
</html>"));
end TranslationTest;
