#!/bin/bash
cleanup_cache() {
  echo "Cleaning cache files..."
  rm -rf /var/cache/*
  echo "Cache files cleaned."
}
