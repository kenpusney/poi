# POI 

![Gem](https://img.shields.io/gem/v/poi.svg) ![Featured](https://img.shields.io/badge/status-featured-blue.svg) ![Automation](https://img.shields.io/badge/profile-automation-blue.svg) ![Tools](https://img.shields.io/badge/profile-utilities-blue.svg)

POI 是一个简单的用来生成文件夹和文件内容结构的工具。

## 安装
```
gem install poi
```

## Usage

```
Usage: poi -f [FILE / URL] [-d]
    -f, --file FILE / URL            Generate using .poi file.
    -d, --delete                     Delete all generated file
    -p, --pack [PACK]                Pack .poipack file into .poi
    -t, --target TARGET              Packaging target
    -h, --help                       Print help message
```

POI 内部使用 Mustache 作为模板。

## 使用方法

```
poi -f <文件名 / URL>
```

POI 会根据 `.poi` 定义的文件结构和模板来在当前目录生成定义文件。这样可以简单作为一个项目模板文件等来使用。

## `.poi` 文件结构

基本结构如下：
```
[文件名] [行数]
[文件内容]
[空行]
...
[结尾的英文句号]
```

示例：

```poi
abc/def/123.txt 3
abc
def
123

hello.c 5
#include <stdio.h>

int main() {
    return printf("hello world");
}

.
```

## 生成 `.poi` 文件

在文件夹加入一个 `.poipack` 文件，可以辅助生成 `*.poi` 文件。

`.poipack` 文件的条目采用 `glob` 语法，如下示例，可以把当前文件夹及其子文件夹下的所有 `.c` 文件生成到 `.poi` 文件中去。

```bash
> cat .poipack
**/**.c
> poi --pack --target c_files.poi
```

## 模板变量

通常推荐在 pack 的时候提供一个 `.poi_defaults` JSON格式文件。这样就能在 Mustache 模板中引用该变量，同样，在展开 POI 文件的时候，可以提供一个 `.poi_vars` 覆盖 `.poi_defaults` 文件中的默认值。