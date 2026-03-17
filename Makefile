.PHONY: proto clean help service_gen

PROTO_SRC_DIR := protos

service_gen:
	mkdir -p service_gen

proto: service_gen
	find ./$(PROTO_SRC_DIR) -name "*.proto" | xargs python3 -m grpc_tools.protoc \
    -I./$(PROTO_SRC_DIR) \
    --python_out=service_gen \
    --grpc_python_out=service_gen
	find service_gen -type d -exec touch {}/__init__.py \;

clean:
	rm -rf service_gen

help:
	@echo "Available targets:"
	@echo "  make proto  - Generate Python protobuf and gRPC stubs"
	@echo "  make clean  - Remove generated files"
	@echo "  make help   - Show this help message"
