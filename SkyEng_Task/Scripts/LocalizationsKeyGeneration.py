import os
import re

def main():
    cwd = os.getcwd()
    directoryPath = "%s/SkyEng_Task/Localizations/Languages/" % cwd

    listOfFiles = []
    for path, subdir, files in os.walk(directoryPath):
        print(subdir)
        for file in files:
            if file.find(".strings") != -1:
                listOfFiles.append(path + "/" + file)

    regularExp = []
    for filePath in listOfFiles:
        fileStrings = open(filePath, "r+")
        regularExp += re.findall("\"[\\w+\\W+]?[^=]*\"\\s*?=\\s*?\"[\\w+\\W+]?[^=]*\";", fileStrings.read())
    
    keysList = set()
    for string in regularExp:
        stringSplit = string.split("=")
        key = find_between(stringSplit[0], "\"", "\"")
        #value = find_between(stringSplit[1], "\"", "\"")
        keysList.add("%s" % key)

    keyPath = "%s/SkyEng_Task/Localizations/LocalizationKeys.swift" % cwd
    fileStrings = open(keyPath, "w+")
    fileStrings.truncate(0)

    newString = "import Foundation \n \nenum LocalizationKeys:String { \n"

    for value in keysList:
        newString += ("\t\tcase " + value + "\n")

    newString += "}"
    fileStrings.write(newString)
        
        
    
def find_between( s, first, last ):
    try:
        start = s.index( first ) + len( first )
        end = s.index( last, start )
        return s[start:end]
    except ValueError:
        return ""

if __name__ == "__main__":
    main()
