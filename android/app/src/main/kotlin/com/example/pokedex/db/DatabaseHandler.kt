package com.example.pokedex.db

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import com.example.pokedex.model.Pokemon

class DatabaseHandler (ctx: Context): SQLiteOpenHelper(ctx,DB_NAME,null,DB_VERSION) {
    override fun onCreate(db: SQLiteDatabase?) {
        val CREATE_TABLE =
            "CREATE TABLE $TABLE_NAME ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $SPRITE TEXT, $STATS TEXT, $TYPES TEXT, $DESCRIPTION TEXT, $WEIGHT INTEGER, $HEIGHT INTEGER);"
        db?.execSQL(CREATE_TABLE)
    }

    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {
        val DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME"
        db?.execSQL(DROP_TABLE)
        onCreate(db)
    }

    fun addPokemon(pokemon: Pokemon): Boolean{
        val db = this.writableDatabase
        val values = ContentValues()
        values.put(NAME, pokemon.name)
        values.put(SPRITE, pokemon.sprite)
        values.put(STATS, pokemon.stats)
        values.put(TYPES, pokemon.types)
        values.put(DESCRIPTION, pokemon.description)
        values.put(WEIGHT, pokemon.weight)
        values.put(HEIGHT, pokemon.height)
        val _success = db.insert(TABLE_NAME,null,values)
        return (("$_success").toInt() != -1)
    }

    fun editPokemon(pokemon: Pokemon): Boolean{
        val db = this.writableDatabase
        val values = ContentValues().apply {
            put(NAME, pokemon.name)
            put(SPRITE, pokemon.sprite)
            put(STATS, pokemon.stats)
            put(TYPES, pokemon.types)
            put(DESCRIPTION, pokemon.description)
            put(WEIGHT, pokemon.weight)
            put(HEIGHT, pokemon.height)
        }
        val _success = db.update(TABLE_NAME, values, ID + "=?", arrayOf(pokemon.id.toString())).toLong()
        db.close()
        return ("$_success").toInt() != -1
    }

    fun getPokemons(): ArrayList<HashMap<String,Any?>> {
        val pokemonList = ArrayList<HashMap<String,Any?>>()
        val db = writableDatabase
        val selectQuery = "SELECT * FROM $TABLE_NAME"
        val cursor = db.rawQuery(selectQuery, null)
        if(cursor != null){
            if(cursor.moveToFirst()){
                do{
                    val pokemon = Pokemon()
                    pokemon.id = cursor.getInt(cursor.getColumnIndexOrThrow(ID))
                    pokemon.name = cursor.getString(cursor.getColumnIndexOrThrow(NAME))
                    pokemon.sprite = cursor.getString(cursor.getColumnIndexOrThrow(SPRITE))
                    pokemon.stats = cursor.getString(cursor.getColumnIndexOrThrow(STATS))
                    pokemon.types = cursor.getString(cursor.getColumnIndexOrThrow(TYPES))
                    pokemon.description = cursor.getString(cursor.getColumnIndexOrThrow(DESCRIPTION))
                    pokemon.weight = cursor.getInt(cursor.getColumnIndexOrThrow(WEIGHT))
                    pokemon.height = cursor.getInt(cursor.getColumnIndexOrThrow(HEIGHT))
                    pokemonList.add(pokemon.toMap())
                }while(cursor.moveToNext())
            }
        }
        cursor.close()
        return pokemonList
    }

    fun removePokemon(_id: Int): Boolean {
        val db = this.writableDatabase
        val _success = db.delete(TABLE_NAME, ID + "=?", arrayOf(_id.toString())).toLong()
        return ("$_success").toInt() != -1
    }

    companion object {
        private val DB_VERSION = 1
        private val DB_NAME = "pokedex"
        private val TABLE_NAME = "pokemons"
        private val ID = "id"
        private val NAME = "name"
        private val SPRITE = "sprite"
        private val STATS = "stats"
        private val TYPES = "types"
        private val DESCRIPTION = "description"
        private val WEIGHT = "weight"
        private val HEIGHT = "height"
    }
}