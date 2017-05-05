module AsteroidShapes exposing (main)

import Html exposing (Html)
import Math.Vector3 as Vector3 exposing (Vec3)
import Random.Pcg as Random


-- project modules

import Asteroid
import Main exposing (view)


main : Html a
main =
    Random.initialSeed 3780540833
        |> Random.step (Random.list (7 * 5) Asteroid.asteroid)
        |> Tuple.first
        |> List.map2
            (\pos object -> { object | position = pos })
            (gridPositions ( 7, 5 ) ( 150, 150 ) |> List.map (Vector3.add (Vector3.vec3 150 150 0)))
        |> view


gridPositions : ( Int, Int ) -> ( Float, Float ) -> List Vec3
gridPositions ( columns, rows ) ( width, height ) =
    List.map
        (\i j -> Vector3.vec3 (toFloat j * width) (toFloat i * height) 0)
        (List.range 0 (rows - 1))
        |> apply (List.range 0 (columns - 1))


{-| <*> for non-determinism List Applicative
-}
apply : List a -> List (a -> b) -> List b
apply =
    List.concatMap << (flip List.map)