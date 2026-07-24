extends Node

var LETTERS = [
	"E","T","M","L","K"
]


func pick_letters(multiple:bool)->Array:
	var letter = LETTERS.pick_random()
	LETTERS.erase(letter)
	var letters:Array
	letters.push_back(letter)
	return letters


func add_letters(letter:Array):
	LETTERS.append_array(letter)
