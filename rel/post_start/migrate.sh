#!/bin/sh

release_ctl eval --mfa "App.ReleaseTasks.migrate/1" --argv -- "$@"