package com.example.pokedex.model

data class Pokemon(
    var id: Int? = 0,
    var name: String? = "",
    var sprite: String? = "",
    var stats: String? = "",
    var types: String? = "",
    var description: String? = "",
    var weight: Int? = 0,
    var height: Int? = 0,
){
    fun toMap(): HashMap<String,Any?>{
        val map:HashMap<String,Any?> = hashMapOf("id" to id, "name" to name, "sprite" to sprite, "stats" to stats, "types" to types, "description" to description,  "weight" to weight, "height" to height)

        return map
    }
}
