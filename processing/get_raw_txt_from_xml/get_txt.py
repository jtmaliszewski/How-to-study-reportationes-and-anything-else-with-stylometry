from pathlib import Path
from bs4 import BeautifulSoup

file_path = Path("176_Hugo-de-S.-Victore_De-sacramentis.xml")
out_path = file_path.with_suffix(".txt")

with file_path.open("r", encoding="utf-8") as file:
    soup = BeautifulSoup(file, "xml")
    text = soup.get_text()

with out_path.open("w", encoding="utf-8") as out:
    out.write(text)
