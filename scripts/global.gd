extends Node

# Bunch of sprite sheets, can add more just seperate with a comma
var head_collection = {
	"01" : preload("res://assets/entity/player/body/head-sheet.png")
}

var body_collection = {
	"01" : preload("res://assets/entity/player/body/body-sheet.png")
}

var hair_collection = {
	"none" : null,
	"01" : preload("res://assets/entity/player/clothing/hair-sheet.png")
}

var shirt_collection = {
	"none" : null,
	"01" : preload("res://assets/entity/player/clothing/shirt-sheet.png")
}

var pants_collection = {
	"none" : null,
	"01" : preload("res://assets/entity/player/clothing/pants-sheet.png")
}

var shoes_collection = {
	"none" : null,
	"01" : preload("res://assets/entity/player/clothing/shoes-sheet.png")
}

# Selected values
var selected_head = "01"
var selected_body = "01"
var selected_hair = "01"
var selected_shirt = "01"
var selected_pants = "01"
var selected_shoes = "01"
