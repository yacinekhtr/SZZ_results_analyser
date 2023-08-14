Class {
	#name : #SZZImporter,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #SZZAnalysis
}

{ #category : #'as yet unclassified' }
SZZImporter class >> findFilesChangedByBugfixesFrom: filePath to: csvFilePath [

	| importer |
	importer := SZZImporter new.
	"filePath := 'H:\SZZUnleashed\sortie\darkreader__darkreader\annotations.json'."
	importer importFrom: filePath.

	"csvFilePath := 'H:\modele_darkreader.csv'."
	importer exportToCSV: csvFilePath
]

{ #category : #'as yet unclassified' }
SZZImporter >> exportToCSV: csvFilePath [
    | csvString |
    csvString := 'Commit ID,Files' , String crlf.
    model do: [ :commit |
        csvString := csvString , commit id , ',' , commit files asString , String crlf.
    ].
    csvFilePath asFileReference writeStreamDo: [ :stream |
        stream nextPutAll: csvString
    ].

]

{ #category : #'import-export' }
SZZImporter >> importCommit: commitID withContent: commitContent [ 
	| commit |
	commit := SZZCommit new.
	commit id: commitID.
	commit files: (commitContent collect: [ :dict | dict at: 'filePath']).
	model add: commit 
]

{ #category : #'import-export' }
SZZImporter >> importFrom: filename [
	model := OrderedCollection new.
	self importJsonDocument: (filename asFileReference readStreamDo: [ :stream |
		NeoJSONReader fromString: stream contents ]).
]

{ #category : #'import-export' }
SZZImporter >> importJsonDocument: json [
	json keysAndValuesDo: [ :commitID :commitContent |
		self importCommit: commitID withContent: commitContent 
	 ]
]
