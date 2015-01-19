#cat "../../../thirdParty/pureweb.min.js" "../../../sources/debugOff.js" "../../../sources/Console.js" "../../../sources/Hub.js" "../../../sources/GlobalStatePW.js" "../../../sources/main.js" "qapp.js" > all.js
cat "../../../sources/debugOff.js" "../../../sources/Console.js" "../../../sources/Hub.js" "../../../sources/GlobalStatePW.js" "../../../sources/main.js" "qapp.js" > all.js
java -jar ../../../thirdParty/closure-compiler/compiler.jar --compilation_level ADVANCED_OPTIMIZATIONS --js=all.js --js_output_file=allc.js

