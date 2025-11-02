#!/usr/bin/env python3
"""
config.yaml contains the base configuration for the Hugo static site generator.
This script reads that configuration and adds language-specific settings
"""
import logging
from typing import Any

import yaml

import list_languages_to_publish


def read_hugo_config():
    with open("config.yaml", "r") as file:
        config_content = file.read()

    return yaml.safe_load(config_content)


def get_languages_to_publish() -> list[str]:
    lang_list = []
    with open("languages_to_publish.txt", "r") as f:
        lang_list = [line.strip() for line in f.readlines() if line.strip()]

    return lang_list

def build_language_config(lang_code: str, lang_name: str, title, title_404, description, rtl: bool):
    lang_config = {
        "lang": lang_code,
        "contentDir": f"content-translated/{lang_code}",
        "languageName": lang_name,
        "title": title,
        "weight": 1,
        "params":
        {
          "lang": lang_code,
          "info":
              {
                  "description": description,
                  "title404": title_404
              }
        }
    }

    if rtl:
        lang_config["LanguageDirection"] = "rtl"

    return lang_config

def build_languages_config(languages: list[str], rtl_languages: list[str]) -> dict[str, Any]:
    log = logging.getLogger("build_languages_config")
    configuration = {
        "languages": {}
    }

    for lang in languages:
        log.info(f"Processing language: {lang}")
        rtl = False
        if lang in rtl_languages:
            log.info("Language is RTL:", lang)
            rtl = True

        try:
            with open(f"l10n/config/site_configuration.{lang}.yml", "r") as file:
                lang_config = yaml.safe_load(file)

            configuration["languages"][lang] = build_language_config(lang_code=lang,
                                                              lang_name=lang_config["languageName"],
                                                              title=lang_config["title"],
                                                              title_404=lang_config["params"]["info"]["title404"],
                                                              description=lang_config["params"]["info"]["description"],
                                                              rtl=rtl)
        except FileNotFoundError as e:
            log.info(f"Error reading configuration for language '{lang}': {e}")
            continue

    configuration["languages"]["fr"]["contentDir"] = "content/fr"

    return configuration


def get_rtl_configuration() -> list:
    with open("l10n/config/language_direction.yml", "r") as file:
        rtl_languages = yaml.safe_load(file)

    return  rtl_languages.keys()

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    log = logging.getLogger("main")
    log.info("Start processing...")
    log.info("🕊 Building Hugo config... 🕊")
    config = read_hugo_config()
    log.info("")
    list_languages_to_publish.build_list()
    log.info("🕊 Reading languages to publish... 🕊")
    languages = get_languages_to_publish()
    log.info(languages)
    languages_with_rtl = get_rtl_configuration()
    languages_config = build_languages_config(languages, languages_with_rtl)
    config["languages"] = languages_config["languages"]
    with open("config.yaml", "w") as file:
        yaml.dump(config, file, default_flow_style=False, allow_unicode=True, sort_keys=False)

    log.info("🕊 Done 🕊")