# Config Export Action

This action reads a config file and exports the values as environment variables.

## Inputs

## `config_path`

**Required** The config path. Default `".github/config.yaml"`.

## `environment`

The environment variables to be exported.

## `debug`

Enable debug mode.

## Outputs

## `config_path`

The config file that was read.

## `config`

The config that was read converted to JSON string.

## `environment`

The environment variables that were exported.

## `matrix`

A list of all environments that can be used in a matrix.

```yaml
strategy:
  matrix:
    include: ${{ fromJson(needs.config-export.outputs.matrix) }}
```

## Example usage

```yaml
uses: tx-pst-dai/config-export@v1
with:
  environment: 'dev'
```