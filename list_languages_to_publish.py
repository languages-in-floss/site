#!/usr/bin/env python3
"""
Identify languages with more than 1 translated articles and save them to languages_to_publish.txt
The threshold for a file to be considered as translated is 80%
"""

import glob
import logging
import os
from collections import defaultdict

from translate.tools.pocount import calcstats

THRESHOLD = 0.8  # 80%
L10N_PATH = "l10n/po" # Path to localization files

def get_po_translation_level(file: str) -> float:
    """
    Call `pocount` to get translation progress for a file
    :param file: Path to .po file
    :return: Translation progress as a float between 0.0 and 1.0
    """

    log = logging.getLogger("buildStats.get_po_translation_level")
    results = defaultdict(int)
    progress = 0.0

    try:
        stat = calcstats(file)
    except Exception as e:
        log.error(f" {file} triggered an {type(e).__name__} exception: {e}")
    else:
        for key in "translatedsourcewords", "fuzzysourcewords", "untranslatedsourcewords":
            results[key] = stat.get(key, 0)

        progress = compute_progress(translated=results["translatedsourcewords"], fuzzy=results["fuzzysourcewords"], untranslated=results["untranslatedsourcewords"])

    return progress

def compute_progress(translated: int, fuzzy: int, untranslated: int) -> float:
    """
    Compute translation progress as a float between 0.0 and 1.0
    :param translated: Number of translated words
    :param fuzzy: Number of fuzzy words
    :param untranslated: Number of untranslated words
    :return: Translation progress as a float between 0.0 and 1.0
    """
    log = logging.getLogger("main")
    try:
        progress = translated / (translated + fuzzy + untranslated)
    except ZeroDivisionError:
        log.error(" Division by zero when computing progress")
        progress = 0.0

    return progress


def save_file(file_path: str, content: list[str]):
    """
    Save content to a file, creating directories if necessary.
    :param file_path: File path
    :param content: Content to save
    :return: None
    """
    with open(file_path, 'w') as file:
        for line in content:
            file.write(line + "\n")


def build_list():
    """ Build the list of languages to publish """
    logging.basicConfig(level=logging.INFO)
    log = logging.getLogger("main")

    languages_to_publish = list()

    for lang in os.listdir(L10N_PATH):
        has_translated_article = False
        lang_path = os.path.join(L10N_PATH, lang)
        log.info(lang)

        files = glob.glob(root_dir=lang_path, pathname="posts/*.po", recursive=True)
        for file in files:
            full_file_path = os.path.join(lang_path, file)
            progress = get_po_translation_level(full_file_path)

            if progress >= THRESHOLD:  # Assuming 80% is the threshold for a file to be considered translated
                log.info(f"{lang} Progress for {full_file_path}: {progress:.2%}")
                has_translated_article = True
                break  # No need to check further files for this language (save resources)

        if has_translated_article:
            languages_to_publish.append(lang)

    languages_to_publish.append("fr")
    languages_to_publish.sort()

    save_file("languages_to_publish.txt", languages_to_publish)
    log.info(f"Languages with translated articles: {languages_to_publish}")

def main():
    """ Main function to run the script """
    build_list()

if __name__ == "__main__":
    main()