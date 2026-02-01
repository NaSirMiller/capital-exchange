from pydantic import BaseModel


class BusinessEvaluationResults(BaseModel):
    pricePerShare: float
    sharesAllowed: int
    businessClass: str
