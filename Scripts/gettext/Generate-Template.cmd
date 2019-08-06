set GETTEXT_PATH=s:\Entwicklung\ModelicaLocalization\gettext\bin\
set PACKAGE_NAME=TranslationTest
set PACKAGE_PATH=..\..\Modelica\%PACKAGE_NAME%
pusd
cd %PACKAGE_PATH%
%GETTEXT_PATH%xgettext --language=EmacsLisp --sort-output --extract-all --from-code=UTF-8 --output=%PACKAGE_PATH%\Resources\Language\%PACKAGE_NAME%.pot package.mo
@popd
@echo Insert the class names as msgctx (eg. msgctxt "TranslationTest.CSVFile") 
