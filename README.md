# Setting Up a Local MCP Environment with Claude Desktop and Docker Desktop on Mac

This guide explains how to set up a local environment on your Mac for working with the **Model Context Protocol (MCP)** using **Claude Desktop** and **Docker Desktop**. The goal is to create a simple yet flexible setup where you can test and build projects that use MCP — a protocol that enables different AI tools and services to communicate by sharing context.

By the end of this guide, you’ll have Claude Desktop running alongside Docker containers that can send and receive context using MCP. We will walk through installing the necessary tools, configuring connections between them, and ensuring everything works smoothly together.

> **Note:** All scripts and commands provided in this guide are based on my personal use case. Alternative options or variations will be noted in footnotes where applicable.

## How to 
1. First, install [Docker Desktop App](https://docs.docker.com/desktop/setup/install/mac-install).
```
  brew install --cask docker
```
2. Next, install a LLM Application. [^More]awdawd
```
  brew install --cask claude 
```
3. Open docker and enable MCP if not enable it.
4. Go to clients and connect the desired application to docker.
5. Next go to catalog an choose MCP servers to run.
> **Important:** If LLM application is open when adding new MCP server quit and reopen app.


[^More]: Applications to use.<br>
        -[Claude Desktop](https://claude.ai/download)<br>
        -[LM Studio](https://lmstudio.ai)<br>
