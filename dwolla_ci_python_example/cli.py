# -*- coding: utf-8 -*-

"""Console script for dwolla_ci_python_example."""
import sys
import click


@click.command()
def main(args=None):
    """Console script for dwolla_ci_python_example."""
    click.echo("Hello, World!")
    return 0


if __name__ == "__main__":
    sys.exit(main())  # pragma: no cover
