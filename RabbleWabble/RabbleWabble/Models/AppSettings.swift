//
//  AppSettings.swift
//  RabbleWabble
//
//  Created by 김승찬 on 2022/04/13.
//

import Foundation

public class AppSettings {
    // MARK: - Keys
    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }
    // MARK: - Static Properties
    public static let shared = AppSettings()
    
    // MARK: - Instance Properties
    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        } set {
            userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Object Lifecycle
    private init() { }
    
    // MARK: - Instance Methods
    public func questionStrategy(for questionGroup: QuestionGroup) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(for: questionGroup)
    }
}

// MARK: - QuestionStrategyType
public enum QuestionStrategyType: Int, CaseIterable {
    
    case random
    case sequential
    
    // MARK: - Instance Methods
    public func title() -> String {
        switch self {
        case .random:
            return "Random"
        case .sequential:
            return "Sequential"
        }
    }
    
    public func questionStrategy(
        for questionGroup: QuestionGroup) -> QuestionStrategy {
            switch self {
            case .random:
                return RandomQuesitionStrategy(questionGroup: questionGroup)
            case .sequential:
                return SequentialQuestionStrategy(questionGroup: questionGroup)
            }
        }
}
