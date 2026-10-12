import argparse
import os
from pathlib import Path

os.environ.setdefault("HF_HOME", str(Path(__file__).resolve().parent / ".cache" / "huggingface"))

from docling.datamodel.base_models import ConversionStatus
from docling.document_converter import DocumentConverter

parser = argparse.ArgumentParser(description="Convert a document to Markdown in result/.")
parser.add_argument("input", type=Path, help="Document file path")
args = parser.parse_args()
source = args.input.resolve()

if not source.is_file():
    parser.error(f"File not found: {source}")

result_dir = Path(__file__).resolve().parent / "result"

result = DocumentConverter().convert(source)
if result.status != ConversionStatus.SUCCESS:
    raise RuntimeError(f"Conversion did not complete: {result.status}")
markdown = result.document.export_to_markdown()
if not markdown.strip():
    raise RuntimeError("Converter returned empty Markdown.")
result_dir.mkdir(exist_ok=True)
index = 0
while True:
    suffix = str(index) if index else ""
    output = result_dir / f"{source.stem}{suffix}.md"
    try:
        file = output.open("x", encoding="utf-8")
        break
    except FileExistsError:
        index += 1
with file:
    file.write(markdown)

print(f"Created: {output}")
