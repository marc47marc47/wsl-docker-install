# Enabling Docker on Oracle Linux in Windows Subsystem for Linux (WSL)

Follow these steps to enable Docker on Oracle Linux running within WSL:

---

### **Quick Installation**

1. After entering WSL, switch to the root user and install the required Linux packages:
   ```bash
   sudo su -
   sh install-docker.sh
   ```

2. Start Docker:
   ```bash
   sh start-docker.sh
   ```

3. Test Docker:
   ```bash
   sh docker-test.sh
   ```

---

### **Step 1: Verify WSL Version**

Ensure you are using **WSL 2**, as Docker requires its features to operate:

1. Open PowerShell or CMD and run the following command to check the WSL version:
   ```powershell
   wsl --list --verbose
   ```

   Verify that your Oracle Linux distribution is using **WSL 2**. If not, set it to WSL 2:
   ```powershell
   wsl --set-version <DistributionName> 2
   ```

---

### **Step 2: Install Docker Engine**

1. **Update the System**  
   In Oracle Linux WSL, update the system and install required tools:
   ```bash
   sudo dnf update -y
   sudo dnf install -y dnf-utils device-mapper-persistent-data lvm2
   ```

2. **Add Docker Yum Repository**  
   ```bash
   sudo dnf config-manager --add-repo=https://download.docker.com/linux/oracle/docker-ce.repo
   ```

3. **Install Docker**  
   ```bash
   sudo dnf install -y docker-ce docker-ce-cli containerd.io
   ```

4. **Verify Docker Installation**  
   ```bash
   docker --version
   ```

---

### **Step 3: Configure Docker**

1. **Start Docker Daemon**  
   Since Docker Daemon does not start automatically in WSL, you need to start it manually.

   **Option 1 (Direct Start):**
   ```bash
   sudo dockerd &
   ```

   **Option 2 (Recommended: Use Docker Desktop):**
   - If Docker Desktop is installed, ensure it is running and configured for WSL 2.
   - In Docker Desktop, enable WSL integration:
     1. Open Docker Desktop.
     2. Navigate to **Settings > Resources > WSL Integration**.
     3. Select **Enable integration with my default WSL distro** and enable Oracle Linux.

2. **Test Docker Daemon**  
   Run the following command to test if Docker is functioning:
   ```bash
   docker run hello-world
   ```

   If successful, you should see output from the Docker test container.

---

### **Step 4: Configure Auto-Start (Optional)**

Docker Daemon does not start automatically with WSL. You can create a script to enable automatic startup:

1. Edit your `~/.bashrc` or `~/.zshrc` file and add the following lines:
   ```bash
   if [ "$(pgrep dockerd)" == "" ]; then
       sudo dockerd > /dev/null 2>&1 &
   fi
   ```

2. Save the file and apply the changes:
   ```bash
   source ~/.bashrc
   ```

---

### **Notes**

1. **Permission Issues**  
   If you encounter permission issues, add the current user to the Docker group:
   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   ```

   Log out and log back in to apply the changes.

2. **System Resources**  
   WSL 2 shares resources with Windows. Ensure sufficient CPU and memory are allocated to WSL 2. Configure this in the `.wslconfig` file:
   - Create a `.wslconfig` file in `%UserProfile%` with the following content:
     ```ini
     [wsl2]
     memory=4GB
     processors=2
     ```

3. **Use Docker Desktop**  
   If manual configuration fails, consider installing Docker Desktop. It provides better management and integration for Docker on WSL.

---

After completing these steps, Docker should function properly on Oracle Linux within WSL.
