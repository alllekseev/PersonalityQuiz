//
//  Question.swift
//  PersonalityQuiz
//
//  Created by Олег Алексеев on 07.04.2023.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum ResponseType {
    case single, multiple, ranged
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вы невероятно общительны. Вы окружаете себя людьми, которых любите, и с удовольствием проводите время со своими друзьями."
        case .cat:
            return "Озорной, но в то же время мягкий по характеру, вы любите все делать по-своему."
        case .rabbit:
            return "Вы любите всё мягкое. Вы здоровы и полны энергии."
        case .turtle:
            return "Вы мудры не по годам и сосредотачиваетесь на деталях. Медленный и устойчивый выигрывает гонку."
        }
    }
}
