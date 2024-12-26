在 Windows Subsystem for Linux (WSL) 的 Oracle Linux 上啟用 Docker，需要進行以下步驟：


### 快速安裝 ###
1. 進入wsl之後, sudo 到su, 並執行 install 相關的linux 套件
```bash
sudo su -
sh install-docker.sh
```

2.啟動docker
```bash
sh start-docker.sh
```

3.測試docker
```bash
sh docker-test.sh
```

---

### **步驟 1: 檢查 WSL 版本**

確保你正在使用 **WSL 2**，因為 Docker 需要 WSL 2 的功能才能運行：

1. 打開 PowerShell 或 CMD，執行以下指令檢查 WSL 版本：
   ```powershell
   wsl --list --verbose
   ```

   確認你的 Oracle Linux 使用的是 **WSL 2**。如果不是，將其設置為 WSL 2：
   ```powershell
   wsl --set-version <DistributionName> 2
   ```

---

### **步驟 2: 安裝 Docker 引擎**

1. **更新系統**
   在 Oracle Linux WSL 中，更新系統並安裝必要的工具：
   ```bash
   sudo dnf update -y
   sudo dnf install -y dnf-utils device-mapper-persistent-data lvm2
   ```

2. **添加 Docker Yum 存儲庫**
   ```bash
   sudo dnf config-manager --add-repo=https://download.docker.com/linux/oracle/docker-ce.repo
   ```

3. **安裝 Docker**
   ```bash
   sudo dnf install -y docker-ce docker-ce-cli containerd.io
   ```

4. **檢查 Docker 安裝是否成功**
   ```bash
   docker --version
   ```

---

### **步驟 3: 配置 Docker**

1. **啟用 Docker Daemon**
   在 WSL 上，Docker Daemon 不會自動啟動，你需要手動運行它。

   **第一種方式（直接啟動）：**
   ```bash
   sudo dockerd &
   ```

   **第二種方式（建議安裝 Docker Desktop）：**
   - 如果你已安裝 Docker Desktop，確保它已開啟並配置 WSL 2。
   - 在 Docker Desktop 中啟用 WSL 集成：
     1. 打開 Docker Desktop。
     2. 進入 **Settings > Resources > WSL Integration**。
     3. 選擇 **Enable integration with my default WSL distro** 並啟用 Oracle Linux。

2. **測試 Docker Daemon**
   使用以下指令測試 Docker 是否運行：
   ```bash
   docker run hello-world
   ```

   如果成功，會看到 Docker 測試容器的輸出。

---

### **步驟 4: 配置自動啟動（可選）**

WSL 中 Docker Daemon 不會隨 WSL 啟動而自動啟動，你可以添加一個腳本來自動啟動 Docker：

1. 編輯 `~/.bashrc` 或 `~/.zshrc` 文件，添加以下內容：
   ```bash
   if [ "$(pgrep dockerd)" == "" ]; then
       sudo dockerd > /dev/null 2>&1 &
   fi
   ```

2. 保存後運行以下指令使其生效：
   ```bash
   source ~/.bashrc
   ```

---

### **注意事項**

1. **權限問題**
   如果遇到權限問題，可以將當前用戶添加到 Docker 群組：
   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   ```

   然後退出並重新進入 WSL。

2. **系統資源**
   WSL 2 與 Windows 共享資源，請確保分配足夠的 CPU 和內存給 WSL 2。這可以在 `.wslconfig` 文件中配置：
   - 在 `%UserProfile%` 路徑下創建 `.wslconfig`：
     ```ini
     [wsl2]
     memory=4GB
     processors=2
     ```

3. **使用 Docker Desktop**
   如果無法手動配置成功，建議安裝 Docker Desktop，這樣可以更好地管理和使用 Docker 在 WSL 上的功能。

---

完成以上步驟後，Docker 應該能在 WSL 的 Oracle Linux 上正常運行。
