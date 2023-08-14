Class {
	#name : #SZZCommit,
	#superclass : #Object,
	#instVars : [
		'id',
		'files'
	],
	#category : #SZZAnalysis
}

{ #category : #accessing }
SZZCommit >> files [

	^ files
]

{ #category : #accessing }
SZZCommit >> files: anObject [

	files := anObject
]

{ #category : #accessing }
SZZCommit >> id [

	^ id
]

{ #category : #accessing }
SZZCommit >> id: anObject [

	id := anObject
]
