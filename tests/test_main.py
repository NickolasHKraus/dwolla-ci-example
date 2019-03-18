#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Tests for `dwolla_ci_example` package."""


import unittest
from click.testing import CliRunner

from dwolla_ci_example import cli


class TestDwollaCiExample(unittest.TestCase):
    """Tests for `dwolla_ci_example` package."""

    def test_command_line_interface(self):
        """Test the CLI."""
        runner = CliRunner()
        result = runner.invoke(cli.main)
        assert result.exit_code == 0
        assert 'Hello, World!' in result.output
        help_result = runner.invoke(cli.main, ['--help'])
        assert help_result.exit_code == 0
        assert '--help  Show this message and exit.' in help_result.output
