package com.example.pokedex

import androidx.annotation.NonNull
import com.example.pokedex.db.DatabaseHandler
import com.example.pokedex.model.Pokemon
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter.pokedex"

    var favoriteList = ArrayList<HashMap<String,Any?>>()
    var databaseHandler = DatabaseHandler(this)

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->
            val arguments = call.arguments<Map<String, Any>>()

            when {
                call.method.equals("getPokemons") -> {
                    getPokemons(result)
                }

                call.method.equals("addPokemon") -> {
                    addPokemon(
                            Pokemon(
                                    null,
                                    arguments!!["name"].toString(),
                                    arguments["sprite"].toString(),
                                    arguments["stats"].toString(),
                                    arguments["types"].toString(),
                                    arguments["description"].toString(),
                                    arguments["weight"].toString().toInt(),
                                    arguments["height"].toString().toInt(),
                            ),
                            result
                    )
                }

                call.method.equals("editPokemon") -> {
                    editPokemon(
                            Pokemon(
                                    arguments!!["id"].toString().toInt(),
                                    arguments["name"].toString(),
                                    arguments["sprite"].toString(),
                                    arguments["stats"].toString(),
                                    arguments["types"].toString(),
                                    arguments["description"].toString(),
                                    arguments["weight"].toString().toInt(),
                                    arguments["height"].toString().toInt(),
                            ),
                            result
                    )
                }

                call.method.equals("removePokemon") -> {
                    removePokemon(arguments!!["id"].toString().toInt(), result)
                }
            }
        }
    }

    private fun getPokemons(result: MethodChannel.Result) {
        favoriteList = databaseHandler.getPokemons()

        result.success(favoriteList);
    }

    private fun addPokemon(pokemon: Pokemon, result: MethodChannel.Result){
        result.success(databaseHandler.addPokemon(pokemon));
    }

    private fun editPokemon(pokemon: Pokemon, result: MethodChannel.Result){
        result.success(databaseHandler.editPokemon(pokemon));
    }

    private fun removePokemon(id: Int, result: MethodChannel.Result){
        result.success(databaseHandler.removePokemon(id));
    }
}
