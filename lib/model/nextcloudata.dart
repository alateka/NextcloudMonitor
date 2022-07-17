class NextcloudData {
  String nextcloudVersion = "";
  int freeSpace = 0;
  List cpuLoad = [0.0, 0.0, 0.0];
  int memTotal = 0;
  int memFree = 0;
  int swapTotal = 0;
  int swapFree = 0;
  String phpVersion = "";

  NextcloudData(
      this.nextcloudVersion,
      this.freeSpace,
      this.cpuLoad,
      this.memTotal,
      this.memFree,
      this.swapTotal,
      this.swapFree,
      this.phpVersion);

  setVersion(String nextcloudVersion) {
    this.nextcloudVersion = nextcloudVersion;
  }

  setFreeSpace(int freeSpace) {
    this.freeSpace = freeSpace;
  }

  setCpuLoad(List cpuLoad) {
    this.cpuLoad = cpuLoad;
  }

  setMemTotal(int memTotal) {
    this.memTotal = memTotal;
  }

  setMemFree(int memFree) {
    this.memFree = memFree;
  }

  setSwapTotal(int swapTotal) {
    this.swapTotal = swapTotal;
  }

  setSwapFree(int swapFree) {
    this.swapFree = swapFree;
  }

  setPhpVersion(String phpVersion) {
    this.phpVersion = phpVersion;
  }

  reloadData(var apiData) {
    setVersion(
      apiData["ocs"]["data"]["nextcloud"]["system"]["version"],
    );
    setFreeSpace(
      apiData["ocs"]["data"]["nextcloud"]["system"]["freespace"],
    );
    setMemTotal(
      apiData["ocs"]["data"]["nextcloud"]["system"]["mem_total"],
    );
    setMemFree(
      apiData["ocs"]["data"]["nextcloud"]["system"]["mem_free"],
    );
    setSwapFree(
      apiData["ocs"]["data"]["nextcloud"]["system"]["swap_free"],
    );
    setSwapTotal(
      apiData["ocs"]["data"]["nextcloud"]["system"]["swap_total"],
    );
    setCpuLoad([
      apiData["ocs"]["data"]["nextcloud"]["system"]["cpuload"][0],
      apiData["ocs"]["data"]["nextcloud"]["system"]["cpuload"][1],
      apiData["ocs"]["data"]["nextcloud"]["system"]["cpuload"][2],
    ]);
    setPhpVersion(apiData["ocs"]["data"]["server"]["php"]["version"]);
  }
}
