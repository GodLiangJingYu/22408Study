# ACM Training - Compile all .c files independently
# CLion default: make all  → compiles every .c into its own .exe
# Terminal usage: make run FILE=problemA

# 编译器选择
CC  = gcc
CXX = g++

# C 语言选项（ACM 常用）+ UTF-8 支持
CFLAGS   = -O2 -Wall -Wextra -std=c17 -finput-charset=UTF-8 -fexec-charset=UTF-8 -lm
# C++ 选项（ACM 常用）+ UTF-8 支持
CXXFLAGS = -O2 -Wall -Wextra -std=c++20 -finput-charset=UTF-8 -fexec-charset=UTF-8 -lm

# 调试模式（需要时手动切换）
# CFLAGS   = -g -O0 -Wall -Wextra -fsanitize=address,undefined -std=c17 -lm
# CXXFLAGS = -g -O0 -Wall -Wextra -fsanitize=address,undefined -std=c++20 -lm

SRCS_C   := $(wildcard *.c)
SRCS_CPP := $(wildcard *.cpp)
EXES     := $(SRCS_C:.c=.exe) $(SRCS_CPP:.cpp=.exe)

.PHONY: all run clean

# Default: build all .c files in the directory
all: $(EXES)

%.exe: %.c
	$(CC) $(CFLAGS) $< -o $@

%.exe: %.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Terminal: make run FILE=problemA
run:
ifndef FILE
	$(error Usage: make run FILE=<filename_without_extension>)
endif
	$(CC) $(CFLAGS) $(FILE).c -o $(FILE).exe && ./$(FILE).exe

clean:
	rm -f *.exe
