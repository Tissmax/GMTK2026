extends Node
const EnemyScene = preload("res://entities/ennemy.tscn")
const GHOST = preload("res://ressources/ghost.tres")
const LINGUISTE = preload("res://ressources/linguiste.tres")
const RAPIDE = preload("res://ressources/rapide.tres")
const STANDARD = preload("res://ressources/standard.tres")

const LETTERS = [
	"E","T","M"
]

enum EnemyType {
	STANDARD,
	GHOST,
	LINGUISTE,
	RAPIDE
}

func _ready():
	creer_vague(3)

func creer_vague(nb_ennemy: int):
	for i in range(nb_ennemy):
		spawn_ennemy(EnemyType.STANDARD)
		print(i)
		
func spawn_ennemy(type: EnemyType):
	var ennemy = EnemyScene.instantiate()
	match type:
		EnemyType.STANDARD:
			ennemy.data = STANDARD
		EnemyType.GHOST:
			ennemy.data = GHOST
		EnemyType.LINGUISTE:
			ennemy.data = LINGUISTE
		EnemyType.RAPIDE:
			ennemy.data = RAPIDE
	ennemy.position = Vector2(
		100,
		-50
		)
	ennemy.letters.push_back(LETTERS.pick_random()) 
	add_child(ennemy)
