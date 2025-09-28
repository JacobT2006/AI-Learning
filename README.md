# Setting Up a Local MCP Environment with Claude Desktop and Docker Desktop on Mac

This guide explains how to set up a local environment on your Mac for working with the **Model Context Protocol (MCP)** using **Claude Desktop** and **Docker Desktop**. The goal is to create a simple yet flexible setup where you can test and build projects that use MCP — a protocol that enables different AI tools and services to communicate by sharing context.

By the end of this guide, you’ll have Claude Desktop running alongside Docker containers that can send and receive context using MCP. We will walk through installing the necessary tools, configuring connections between them, and ensuring everything works smoothly together.

> **Note:** All scripts and commands provided in this guide are based on my personal use case. Alternative options or variations will be noted in footnotes where applicable.

## Setup Instructions

### 1. Install Docker Desktop

First, install [Docker Desktop App](https://docs.docker.com/desktop/setup/install/mac-install).

Alternatively, install through Homebrew: 

```
  brew install --cask docker
```

### 2. Install a Large Language Model (LLM) Application

Next, install your choice Application links listed here. -> [^More]

```
  brew install --cask claude 
```

### 3. Enable MCP in Docker

Open Docker and enable MCP. If it is not enabled by default, activate it in settings.

### 4. Connect LLM Application to Docker

Go to **Clients** under **MCP Toolkits** and connect the desired application to docker.

![Docker Reference]()

### 5. Run MCP Servers from catalog

Next within Docker go to catalog an choose MCP servers to run.
> **Important:** If your LLM application is open when adding new MCP server quit and reopen app.


[^More]: Applications to use.<br>
        -[Claude Desktop](https://claude.ai/download)<br>
        -[LM Studio](https://lmstudio.ai)<br>
