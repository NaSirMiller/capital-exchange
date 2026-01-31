from typing import Optional

from openrouter import OpenRouter
import pymupdf


class OpenRouterError(Exception):
    pass


class PDFExtractionError(Exception):
    pass


class OpenRouterClient:
    def __init__(
        self,
        model_name: str,
        open_router_client: OpenRouter,
    ) -> None:
        self.model_name = model_name
        self.open_router_client = open_router_client

    def get_response(self, query: str, system_prompt: Optional[str] = None) -> str:
        messages = []

        if not isinstance(query, str) or not (
            isinstance(system_prompt, None) or isinstance(system_prompt, str)
        ):
            raise ValueError("Provided query or system prompt is not a str type")

        if system_prompt:
            messages.append({"role": "system", "content": system_prompt})
        messages.append({"role": "user", "content": query})

        try:
            resp = self.open_router_client.chat.send(
                model=self.model_name, messages=messages
            )

        except Exception as e:
            raise OpenRouterError(f"OpenRouter request failed: {e}")

        try:
            content = resp["choices"][0]["message"]["content"]
        except Exception as e:
            raise OpenRouterError("Could not get message content from OpenRouter")

        return content


class DocumentTextExtractionClient:
    def __init__(self) -> None:
        pass

    def extract_text_from_pdf(self, pdf_path: str) -> list[str]:
        pdf_text: list[str] = []
        try:
            with open(pdf_path) as pdf_file:
                pass
        except Exception as e:
            raise PDFExtractionError(
                f"Could not extract text from pdf located at {pdf_path}"
            )
