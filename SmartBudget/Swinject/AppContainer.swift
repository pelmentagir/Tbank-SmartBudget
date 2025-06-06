import UIKit
import Swinject

final class AppContainer {

    // MARK: Properties
    private var container = Container()

    // MARK: Initializated
    init() {
        setupDependency()
    }

    // MARK: Public Methods
    func resolveController<T: FlowController>(_ type: T.Type) -> T {
        guard let controller = container.resolve(type) else {
            fatalError("Controller of type \(type) not registered.")
        }
        return controller
    }

    func resolveController<T: FlowController, Arg>(_ type: T.Type, argument: Arg) -> T {
        guard let controller = container.resolve(type, argument: argument) else {
            fatalError("Controller of type \(type) with argument \(argument) not registered.")
        }
        return controller
    }

    // MARK: Private Methods
    private func setupDependency() {

        // MARK: ViewModels
        container.register(LoginViewModel.self) { _ in
            return LoginViewModel()
        }

        container.register(CodeVerificationViewModel.self) { _ in
            return CodeVerificationViewModel()
        }

        container.register(RegistrationViewModel.self) { _ in
            return RegistrationViewModel()
        }

        container.register(CreateProfileViewModel.self) { _ in
            return CreateProfileViewModel()
        }

        container.register(MainViewModel.self) { _ in
            return MainViewModel()
        }

        container.register(SavingViewModel.self) { _ in
            return SavingViewModel()
        }

        container.register(OperationViewModel.self) { _ in
            return OperationViewModel()
        }

        container.register(ProfitViewModel.self) { _ in
            return ProfitViewModel()
        }

        container.register(CategoryDistributionViewModel.self) { _ in
            return CategoryDistributionViewModel()
        }

        container.register(BudgetPlanningViewModel.self) { (_, category: Category) in
            return BudgetPlanningViewModel(category: category)
        }

        container.register(ReplenishViewModel.self) { (_, savingGoal: SavingGoal) in
            return ReplenishViewModel(savingGoal: savingGoal)
        }

        container.register(FirstScreenAddingGoalViewModel.self) { _ in
            return FirstScreenAddingGoalViewModel()
        }

        container.register(SecondScreenAddingGoalViewModel.self) { _ in
            return SecondScreenAddingGoalViewModel()
        }

        container.register(ThirdScreenAddingGoalViewModel.self) { _ in
            return ThirdScreenAddingGoalViewModel()
        }
        
        container.register(IncomeDistributionViewModel.self) { _ in
            return IncomeDistributionViewModel()
        }

        // MARK: Controller
        container.register(LoginViewController.self) { resolver in
            return LoginViewController(viewModel: resolver.resolve(LoginViewModel.self)!)
        }

        container.register(CodeVerificationViewController.self) { resolver in
            return CodeVerificationViewController(viewModel: resolver.resolve(CodeVerificationViewModel.self)!)
        }

        container.register(RegistrationViewController.self) { resolver in
            return RegistrationViewController(viewModel: resolver.resolve(RegistrationViewModel.self)!)
        }

        container.register(CreateProfileViewController.self) { resolver in
            return CreateProfileViewController(viewModel: resolver.resolve(CreateProfileViewModel.self)!)
        }

        container.register(ProfitViewController.self) { resolver in
            return ProfitViewController(viewModel: resolver.resolve(ProfitViewModel.self)!)
        }

        container.register(CategoryDistributionViewController.self) { resolver in
            return CategoryDistributionViewController(viewModel: resolver.resolve(CategoryDistributionViewModel.self)!)
        }

        container.register(BudgetPlanningViewController.self) { (resolver, category: Category) in
            let viewModel = resolver.resolve(BudgetPlanningViewModel.self, argument: category)!
            return BudgetPlanningViewController(viewModel: viewModel)
        }

        container.register(MainViewController.self) { resolver in
            return MainViewController(viewModel: resolver.resolve(MainViewModel.self)!)
        }

        container.register(SavingViewController.self) { resolver in
            return SavingViewController(viewModel: resolver.resolve(SavingViewModel.self)!)
        }

        container.register(OperationViewController.self) { resolver in
            return OperationViewController(viewModel: resolver.resolve(OperationViewModel.self)!)
        }

        container.register(ReplenishViewController.self) { (resolver, savingGoal: SavingGoal) in
            let viewModel = resolver.resolve(ReplenishViewModel.self, argument: savingGoal)!
            return ReplenishViewController(viewModel: viewModel)
        }

        container.register(FirstScreenAddingGoalViewController.self) { resolver in
            return FirstScreenAddingGoalViewController(viewModel: resolver.resolve(FirstScreenAddingGoalViewModel.self)!)
        }

        container.register(SecondScreenAddingGoalViewController.self) { resolver in
            return SecondScreenAddingGoalViewController(viewModel: resolver.resolve(SecondScreenAddingGoalViewModel.self)!)
        }

        container.register(ThirdScreenAddingGoalViewController.self) { resolver in
            return ThirdScreenAddingGoalViewController(viewModel: resolver.resolve(ThirdScreenAddingGoalViewModel.self)!)
        }
        
        container.register(IncomeDistributionViewController.self) { resolver in
            return IncomeDistributionViewController(viewModel: resolver.resolve(IncomeDistributionViewModel.self)!)
        }
    }
}
