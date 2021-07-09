module Decode.SpringDataRestSpiel exposing (..)

import Json.Decode



-- generated from http://korban.net/elm/json2elm/


type alias SpieleCollection =
    { embedded : Embedded
    , links : LinksCollection
    , page : Page
    }


type alias Embedded =
    { spiele : List EmbeddedSpieleObject
    }


type alias EmbeddedSpieleObject =
    { altersempfehlung : Int
    , altersempfehlungMax : Int
    , attachments : List AttachmentsObject
    , beschreibung : String
    , coverBildId : Maybe String
    , erscheinugsjahr : Maybe String
    , id : Int
    , kategorie : Kategorie
    , leihpreis : Int
    , links : LinksItem
    , name : String
    , spieldauerMinutenMax : Int
    , spieldauerMinutenMin : Int
    , spieldauerTyp : Maybe SpieldauerTyp
    , spieleranzahlMax : Int
    , spieleranzahlMin : Int
    }


type alias Kategorie =
    { id : Int
    , name : String
    }


type alias AttachmentsObject =
    { name : String
    , preview : List AttachmentsObjectPreviewObject
    , trelloId : String
    }


type alias AttachmentsObjectPreviewObject =
    { bytes : Int
    , height : Int
    , scaled : Bool
    , trelloId : String
    , width : Int
    }


type SpieldauerTyp
    = Einwert
    | ProSpieler
    | MinMax
    | Beliebig


type alias EmbeddedSpieleObjectLinks =
    { self : EmbeddedSpieleObjectLinksSelf
    , spiel : EmbeddedSpieleObjectLinksSpiel
    }


type alias EmbeddedSpieleObjectLinksSelf =
    { href : String
    }


type alias EmbeddedSpieleObjectLinksSpiel =
    { href : String
    }


type alias LinksItem =
    { profile : LinksProfile
    , self : LinksSelf
    }


type alias LinksSpiel =
    { href : String
    }


type alias Page =
    { number : Int
    , size : Int
    , totalElements : Int
    , totalPages : Int
    }


type alias CollectionLinks =
    { links : LinksItem
    }


type alias LinksCollection =
    { first : LinksFirst
    , last : LinksLast
    , next : LinksNext
    , profile : LinksProfile
    , search : LinksSearch
    , self : LinksSelf
    }


type alias LinksFirst =
    { href : String
    }


type alias LinksSelf =
    { href : String
    }


type alias LinksNext =
    { href : String
    }


type alias LinksLast =
    { href : String
    }


type alias LinksProfile =
    { href : String
    }


type alias LinksSearch =
    { href : String
    }


decodeLinksCollection : Json.Decode.Decoder LinksCollection
decodeLinksCollection =
    Json.Decode.map6 LinksCollection
        (Json.Decode.field "first" decodeLinksFirst)
        (Json.Decode.field "last" decodeLinksLast)
        (Json.Decode.field "next" decodeLinksNext)
        (Json.Decode.field "profile" decodeLinksProfile)
        (Json.Decode.field "search" decodeLinksSearch)
        (Json.Decode.field "self" decodeLinksSelf)


decodeLinksFirst : Json.Decode.Decoder LinksFirst
decodeLinksFirst =
    Json.Decode.map LinksFirst
        (Json.Decode.field "href" Json.Decode.string)


decodeLinksNext : Json.Decode.Decoder LinksNext
decodeLinksNext =
    Json.Decode.map LinksNext
        (Json.Decode.field "href" Json.Decode.string)


decodeLinksLast : Json.Decode.Decoder LinksLast
decodeLinksLast =
    Json.Decode.map LinksLast
        (Json.Decode.field "href" Json.Decode.string)


decodeLinksSearch : Json.Decode.Decoder LinksSearch
decodeLinksSearch =
    Json.Decode.map LinksSearch
        (Json.Decode.field "href" Json.Decode.string)


decodeSpieleCollection : Json.Decode.Decoder SpieleCollection
decodeSpieleCollection =
    Json.Decode.map3 SpieleCollection
        (Json.Decode.field "_embedded" decodeEmbedded)
        (Json.Decode.field "_links" decodeLinksCollection)
        (Json.Decode.field "page" decodePage)


decodeEmbedded : Json.Decode.Decoder Embedded
decodeEmbedded =
    Json.Decode.map Embedded
        (Json.Decode.field "spiele" <| Json.Decode.list decodeEmbeddedSpieleObject)


decodeEmbeddedSpiele : Json.Decode.Decoder (List EmbeddedSpieleObject)
decodeEmbeddedSpiele =
    Json.Decode.list decodeEmbeddedSpieleMember


decodeKategorie : Json.Decode.Decoder Kategorie
decodeKategorie =
    Json.Decode.map2 Kategorie
        (Json.Decode.field "id" Json.Decode.int)
        (Json.Decode.field "name" Json.Decode.string)


decodeEmbeddedSpieleMember : Json.Decode.Decoder EmbeddedSpieleObject
decodeEmbeddedSpieleMember =
    decodeEmbeddedSpieleObject


decodeEmbeddedSpieleObject : Json.Decode.Decoder EmbeddedSpieleObject
decodeEmbeddedSpieleObject =
    let
        fieldSet0 =
            Json.Decode.map8 EmbeddedSpieleObject
                (Json.Decode.field "altersempfehlung" Json.Decode.int)
                (Json.Decode.field "altersempfehlungMax" Json.Decode.int)
                (Json.Decode.field "attachments" <| Json.Decode.list decodeAttachmentsObject)
                (Json.Decode.field "beschreibung" Json.Decode.string)
                (Json.Decode.maybe (Json.Decode.field "coverBildId" Json.Decode.string))
                (Json.Decode.maybe (Json.Decode.field "erscheinugsjahr" <| Json.Decode.string))
                (Json.Decode.field "id" Json.Decode.int)
                (Json.Decode.field "kategorie" decodeKategorie)

        fieldSet1 =
            Json.Decode.map8 (<|)
                fieldSet0
                (Json.Decode.field "leihpreis" Json.Decode.int)
                (Json.Decode.field "_links" decodeSpielLinks)
                (Json.Decode.field "name" Json.Decode.string)
                (Json.Decode.field "spieldauerMinutenMax" Json.Decode.int)
                (Json.Decode.field "spieldauerMinutenMin" Json.Decode.int)
                (Json.Decode.maybe (Json.Decode.field "spieldauerTyp" spieldauerTypDecoder))
                (Json.Decode.field "spieleranzahlMax" Json.Decode.int)
    in
    Json.Decode.map2 (<|)
        fieldSet1
        (Json.Decode.field "spieleranzahlMin" Json.Decode.int)


decodeMaybeWithDefault : a -> Maybe a -> Json.Decode.Decoder a
decodeMaybeWithDefault default maybe =
    case maybe of
        Just x ->
            Json.Decode.succeed x

        Nothing ->
            Json.Decode.succeed default


spieldauerTypDecoder : Json.Decode.Decoder SpieldauerTyp
spieldauerTypDecoder =
    Json.Decode.field "spieldauerTyp" Json.Decode.string
        |> Json.Decode.andThen
            (\str ->
                case str of
                    "Einwert" ->
                        Json.Decode.succeed Einwert

                    "ProSpieler" ->
                        Json.Decode.succeed ProSpieler

                    "MinMax" ->
                        Json.Decode.succeed MinMax

                    "Beliebig" ->
                        Json.Decode.succeed Beliebig

                    _ ->
                        Json.Decode.fail ("Trying to decode, but spieldauerTyp " ++ str ++ " is not supported.")
            )


decodeEmbeddedSpieleObjectLinks : Json.Decode.Decoder EmbeddedSpieleObjectLinks
decodeEmbeddedSpieleObjectLinks =
    Json.Decode.map2 EmbeddedSpieleObjectLinks
        (Json.Decode.field "self" decodeEmbeddedSpieleObjectLinksSelf)
        (Json.Decode.field "spiel" decodeEmbeddedSpieleObjectLinksSpiel)


decodeEmbeddedSpieleObjectLinksSelf : Json.Decode.Decoder EmbeddedSpieleObjectLinksSelf
decodeEmbeddedSpieleObjectLinksSelf =
    Json.Decode.map EmbeddedSpieleObjectLinksSelf
        (Json.Decode.field "href" Json.Decode.string)


decodeEmbeddedSpieleObjectLinksSpiel : Json.Decode.Decoder EmbeddedSpieleObjectLinksSpiel
decodeEmbeddedSpieleObjectLinksSpiel =
    Json.Decode.map EmbeddedSpieleObjectLinksSpiel
        (Json.Decode.field "href" Json.Decode.string)


decodeSpielLinks : Json.Decode.Decoder LinksItem
decodeSpielLinks =
    Json.Decode.map2 LinksItem
        (Json.Decode.field "spiel" decodeLinksProfile)
        (Json.Decode.field "self" decodeLinksSelf)


decodeLinksSelf : Json.Decode.Decoder LinksSelf
decodeLinksSelf =
    Json.Decode.map LinksSelf
        (Json.Decode.field "href" Json.Decode.string)


decodeLinksProfile : Json.Decode.Decoder LinksProfile
decodeLinksProfile =
    Json.Decode.map LinksProfile
        (Json.Decode.field "href" Json.Decode.string)


decodePage : Json.Decode.Decoder Page
decodePage =
    Json.Decode.map4 Page
        (Json.Decode.field "number" Json.Decode.int)
        (Json.Decode.field "size" Json.Decode.int)
        (Json.Decode.field "totalElements" Json.Decode.int)
        (Json.Decode.field "totalPages" Json.Decode.int)


decodeAttachments : Json.Decode.Decoder (List AttachmentsObject)
decodeAttachments =
    Json.Decode.list decodeAttachmentsMember


decodeAttachmentsMember : Json.Decode.Decoder AttachmentsObject
decodeAttachmentsMember =
    decodeAttachmentsObject


decodeAttachmentsObject : Json.Decode.Decoder AttachmentsObject
decodeAttachmentsObject =
    Json.Decode.map3 AttachmentsObject
        (Json.Decode.field "name" Json.Decode.string)
        (Json.Decode.field "preview" <| Json.Decode.list decodeAttachmentsObjectPreviewObject)
        (Json.Decode.field "trelloId" Json.Decode.string)


decodeAttachmentsObjectPreview : Json.Decode.Decoder (List AttachmentsObjectPreviewObject)
decodeAttachmentsObjectPreview =
    Json.Decode.list decodeAttachmentsObjectPreviewMember


decodeAttachmentsObjectPreviewMember : Json.Decode.Decoder AttachmentsObjectPreviewObject
decodeAttachmentsObjectPreviewMember =
    decodeAttachmentsObjectPreviewObject


decodeAttachmentsObjectPreviewObject : Json.Decode.Decoder AttachmentsObjectPreviewObject
decodeAttachmentsObjectPreviewObject =
    Json.Decode.map5 AttachmentsObjectPreviewObject
        (Json.Decode.field "bytes" Json.Decode.int)
        (Json.Decode.field "height" Json.Decode.int)
        (Json.Decode.field "scaled" Json.Decode.bool)
        (Json.Decode.field "trelloId" Json.Decode.string)
        (Json.Decode.field "width" Json.Decode.int)
