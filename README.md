# Installation

run `bundle install`

# Run specs

run `rspec`

# Class Descriptions

## DataProcessorInterface
Defines a class that wraps the execution of all defined processors inside the directory processors

### Usage

```
  DataProcessorInterface.new({
    type: <Symbol>,
    file_path: <String>
  }).run
```

- type: needs to be one of the symbols defined as constants in TYPE for each processor
- file_path: needs to be a corect file_path to be processed

## SoccerProcessor
Defines a class that reads the given file and processes the contents.

### Usage

```
  SoccerProcessor.new({
    file_path: <String>
  }).smallest_delta
```

## TemperatureProcessor
Defines a class that reads the given file and processes the contents.

### Usage

```
  TemperatureProcessor.new({
    file_path: <String>
  }).smallest_delta
```
