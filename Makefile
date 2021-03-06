TEST_LIST_DIR := test/list
TEST_HEAP_DIR := test/heap
TEST_MAP_DIR := test/map
OBJ_DIR := obj
OBJ_LIST_DIR := obj/list
OBJ_HEAP_DIR := obj/heap
OBJ_MAP_DIR := obj/map
BIN_DIR := bin

TEST_LIST := $(wildcard $(TEST_LIST_DIR)/*.c)
TEST_HEAP := $(wildcard $(TEST_HEAP_DIR)/*.c)
TEST_MAP := $(wildcard $(TEST_MAP_DIR)/*.c)

OBJ_LIST := $(TEST_LIST:$(TEST_LIST_DIR)/%.c=$(OBJ_LIST_DIR)/%.o)
OBJ_HEAP := $(TEST_HEAP:$(TEST_HEAP_DIR)/%.c=$(OBJ_HEAP_DIR)/%.o)
OBJ_MAP := $(TEST_MAP:$(TEST_MAP_DIR)/%.c=$(OBJ_MAP_DIR)/%.o)

CPPFLAGS := -Isrc
LDFLAGS  := -Llib
LDLIBS   := -lm

.PHONY: all clean

list: $(OBJ_LIST) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o bin/$@

heap: $(OBJ_HEAP) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o bin/$@

map: $(OBJ_MAP) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o bin/$@

$(OBJ_LIST_DIR)/%.o: $(TEST_LIST_DIR)/%.c | $(OBJ_LIST_DIR)
	$(CC) $(CPPFLAGS) -c $< -o $@

$(OBJ_HEAP_DIR)/%.o: $(TEST_HEAP_DIR)/%.c | $(OBJ_HEAP_DIR)
	$(CC) $(CPPFLAGS) -c $< -o $@

$(OBJ_MAP_DIR)/%.o: $(TEST_MAP_DIR)/%.c | $(OBJ_MAP_DIR)
	$(CC) $(CPPFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR) $(OBJ_LIST_DIR) $(OBJ_HEAP_DIR) $(OBJ_MAP_DIR):
	mkdir -p $@

clean:
	@$(RM) -rv $(BIN_DIR) $(OBJ_DIR)

-include $(OBJ_LIST:.o=.d)