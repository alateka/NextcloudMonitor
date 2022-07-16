class NextcloudData {
  String version = '';
  int freeSpace = 0;
  List cpuLoad = [0.0, 0.0, 0.0];
  int memTotal = 0;
  int memFree = 0;
  int swapTotal = 0;
  int swapFree = 0;

  NextcloudData(
    this.version,
    this.freeSpace,
    this.cpuLoad,
    this.memTotal,
    this.memFree,
    this.swapTotal,
    this.swapFree,
  );

  setVersion(String version) {
    this.version = version;
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
  }
}
