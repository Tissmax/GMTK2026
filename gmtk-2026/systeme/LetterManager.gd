extends Node

var LETTERS = [
	"E","T","M","L","K"
]


func pick_letters(multiple:bool)->Array:
	var letters:Array
	if not multiple:
		var letter = LETTERS.pick_random()
		LETTERS.erase(letter)
		letters.push_back(letter)
	print(LETTERS)
	return letters
	

func add_letters(letter:Array):
	LETTERS.append_array(letter)
