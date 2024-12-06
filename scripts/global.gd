extends Node

# Bunch of sprite sheets, can add more just seperate with a comma
var head_collection = {
	"01" : preload("res://assets/sprites/character/body/head-sheet.png")
}

var body_collection = {
	"01" : preload("res://assets/sprites/character/body/body-sheet.png")
}

var hair_collection = {
	"none" : null,
	"01" : preload("res://assets/sprites/character/clothing/hair-sheet.png")
}

var shirt_collection = {
	"none" : null,
	"01" : preload("res://assets/sprites/character/clothing/shirt-sheet.png")
}

var pants_collection = {
	"none" : null,
	"01" : preload("res://assets/sprites/character/clothing/pants-sheet.png")
}

var shoes_collection = {
	"none" : null,
	"01" : preload("res://assets/sprites/character/clothing/shoes-sheet.png")
}

# Selected values
var selected_head = "01"
var selected_body = "01"
var selected_hair = "none"
var selected_shirt = "none"
var selected_pants = "none"
var selected_shoes = "none"
