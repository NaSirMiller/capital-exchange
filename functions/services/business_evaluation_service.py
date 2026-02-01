from models.business import Business
from models.evaluation_results import BusinessEvaluationResults
from repositories.business_repository import (
    business_repository,
    BusinessRepositoryError,
)


class BusinessEvaluationServiceError(Exception):
    pass


PROFIT_TO_BUSINESS_CLASSES: dict[str, tuple[int, int | float]] = {
    "micro": (0, 249_999),
    "small": (250_000, 499_999),
    "large": (500_000, 999_999),
    "in_demand": (1_000_000, float("inf")),
}
BUSINESS_CLASSES_TO_SHARES_ALLOWED: dict[str, int] = {
    "micro": 1_000,
    "small": 2_500,
    "large": 5_000,
    "in_demand": 10_000,
}
BUSINESS_CLASSES_TO_PL_BONUS: dict[str, int] = {
    "micro": 2,
    "small": 2.5,
    "large": 3,
    "in_demand": 4,
}


class BusinessEvaluationService:
    def _assign_business_class(self, business_id: str, net_profit: float) -> str:
        business_class: str | None = None
        for b_class, (lower, upper) in PROFIT_TO_BUSINESS_CLASSES.items():
            if lower <= net_profit <= upper:
                business_class = b_class
                break
        if business_class is None:
            raise RuntimeError(
                f"Could not assign a business class to business with id={business_id}"
            )
        return business_class

    def get_evaluation(self, business_id: str) -> BusinessEvaluationResults:

        try:
            business = business_repository.get_business_by_id(business_id)
        except BusinessRepositoryError as e:
            raise BusinessEvaluationServiceError(
                f"Could not retrieve data for business with id={business_id}"
            )

        net_profit: float = business.projectedRevenue - business.projectedExpenses

        try:
            business_class = self._assign_business_class(business_id, net_profit)
        except RuntimeError as e:
            raise BusinessEvaluationServiceError("Could not assign a business class")

        shares_allowed: int = BUSINESS_CLASSES_TO_SHARES_ALLOWED[business_class]
        business_bonus: int = BUSINESS_CLASSES_TO_PL_BONUS[business_class]

        price_per_share: float = (net_profit * business_bonus) / shares_allowed

        return BusinessEvaluationResults(
            pricePerShare=price_per_share,
            sharesAllowed=shares_allowed,
            businessClass=business_class,
        )
