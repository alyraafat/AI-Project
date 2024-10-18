import java.lang.management.ManagementFactory;
import java.lang.management.ThreadMXBean;

import java.util.HashSet;

public class WaterSortSearch extends GenericSearch {
    private String noSolution = "NOSOLUTION";

    public boolean goalFunc(Node n) {
        for (WaterBottle wb : n.waterBottles) {
            if (!wb.isSameColor)
                return false;
        }
        return true;
    }

    public static String solve(String initialState, String strategy, boolean visualize) throws Exception {
        WaterSortSearch problem = new WaterSortSearch();
        Node initNode = problem.decodeInitString(initialState);
        // System.out.println(stateToString(initNode));
        QingFun qingFun = problem.decodeStrategy(strategy);
        Node res = null;
        if (qingFun instanceof IDS) {
            res = problem.solveForIDS(initNode, (IDS) qingFun);
        } else {
            res = problem.generalSearch(initNode, qingFun);
        }
        // System.out.println("here2");
        if (res == null)
            return problem.noSolution;
        if (visualize)
            System.out.println(visualizeSteps(res));
        ;
        return problem.encodeOutput(res);
    }

    public Node solveForIDS(Node initNode, IDS ids) {
        int i = 0;
        while (!ids.getAllNodesDepthLessThanCurrDepth()) {
            ids.setSeen(new HashSet<>());
            ids.setCurrDepth(i);
            Node res = this.generalSearch(initNode, ids);
            if (res != null)
                return res;
            i++;
        }
        return null;
    }

    public static String visualizeSteps(Node node) {
        if (node.parent == null) {
            return stateToString(node);
        }

        return visualizeSteps(node.parent) + "\n" + stateToString(node);
    }

    public static String stateToString(Node node) {
        StringBuilder result = new StringBuilder();
        WaterBottle[] waterBottles = node.waterBottles;
        int bottleLength = waterBottles[0].capacity;
        result.append(node.operator != null ? "After " + node.operator + "\n" : "Start" + "\n");
        for (int i = 0; i < bottleLength; i++) {
            for (int j = 0; j < waterBottles.length; j++) {
                String color = waterBottles[j].colors[i];
                result.append(" ").append(color).append(" |"); // Added space before color for alignment
            }
            result.append("\n");
        }

        for (int k = 0; k < waterBottles.length; k++) {
            result.append("--- ");
        }
        result.append("\n");

        for (int k = 0; k < waterBottles.length; k++) {
            result.append(" ").append(k).append("  ");
        }
        result.append("\n" + "-----------------------------------------");
        return result.toString();
    }

    public Node decodeInitString(String initialState) {
        String[] elems = initialState.split(";");
        int numberOfBottles = Integer.parseInt(elems[0]);
        int bottleCapacity = Integer.parseInt(elems[1]);
        WaterBottle[] wbs = new WaterBottle[numberOfBottles];
        for (int i = 2; i < elems.length; i++) {
            WaterBottle wb = new WaterBottle(elems[i], bottleCapacity, i - 2);
            wbs[i - 2] = wb;
        }
        return new Node(null, 0, 0, null, wbs);
    }

    public QingFun decodeStrategy(String strategy) throws Exception {
        switch (strategy.toLowerCase()) {
            case "bf":
                return new BFS();
            case "df":
                return new DFS();
            case "uc":
                return new UCS();
            case "id":
                return new IDS();
            case "as1":
                return new AStar1();
            case "as2":
                return new AStar2();
            case "gr1":
                return new Greedy1();
            case "gr2":
                return new Greedy2();
            default:
                throw new Exception("Input a valid strategy [bf, df, uc, id, as1, as2, gr1, gr2]");
        }
    }

    public static double getProcessCpuLoad() {
        com.sun.management.OperatingSystemMXBean osBean = (com.sun.management.OperatingSystemMXBean) ManagementFactory
                .getOperatingSystemMXBean();
        return osBean.getProcessCpuLoad() * 100; // CPU load as a percentage
    }

    public String encodeOutput(Node node) {
        int cost = node.cost;
        int nodesExpanded = this.nodesExpanded;
        String plan = node.path;
        return plan + ";" + cost + ";" + nodesExpanded;
    }

    public static void main(String[] args) throws Exception {
        Runtime runtime = Runtime.getRuntime();
        ThreadMXBean threadBean = ManagementFactory.getThreadMXBean();
        System.gc();

        // Calculate initial memory usage
        long startMemory = runtime.totalMemory() - runtime.freeMemory();

        // Record initial CPU time and wall-clock time
        double startCpuTime = threadBean.getCurrentThreadCpuTime();
        double startWallClockTime = System.nanoTime();
        System.out.println("startCpuTime : " + startCpuTime);
        String init = "6;6;"
                + "e,e,e,g,r,r;" // Bottle 0
                + "e,e,e,r,b,b;" // Bottle 1
                + "e,e,e,b,y,g;" // Bottle 2
                + "e,e,e,g,r,y;" // Bottle 3
                + "e,e,e,e,e,e;" // Bottle 6 (empty)
                + "e,e,e,e,e,e;"; // Bottle 9 (empty)

        String grid = "6;" + "3;" + "r,r,y;" + "b,y,r;" + "y,b,g;" + "g,g,b;" + "e,e,e;" + "e,e,e;";

        // double before = getProcessCpuLoad();
        String result = WaterSortSearch.solve(init, "GR2", true);
        // double after = getProcessCpuLoad();
        System.out.println("result :	 " + result);
        // System.out.println("Before : " + (before));
        // System.out.println("After : " + (after));
        // System.out.println("CPU : " + (after - before));
        // // Calculate final memory usage
        long endMemory = runtime.totalMemory() - runtime.freeMemory();
        long memoryUsed = endMemory - startMemory;

        // Record final CPU time and wall-clock time
        double endCpuTime = threadBean.getCurrentThreadCpuTime();
        double endWallClockTime = System.nanoTime();

        System.out.println("endCpuTime : " + endCpuTime);

        // Calculate CPU time used and wall-clock time
        double cpuTimeUsed = endCpuTime - startCpuTime;
        double wallClockTimeElapsed = endWallClockTime - startWallClockTime;
        // System.out.println("cpuTimeUsed : " + cpuTimeUsed);
        // System.out.println("wallClockTimeElapsed : " + wallClockTimeElapsed);
        // System.out.println("runtime.availableProcessors() : " +
        // runtime.availableProcessors());

        // Adjust CPU Utilization calculation
        double cpuUtilization = (double) cpuTimeUsed / (wallClockTimeElapsed) * 100;

        // Display results
        System.out.println("Memory used (MB): " + (memoryUsed / (1024 * 1024)));
        System.out.println("CPU utilization (%): " + cpuUtilization);
        System.out.println("ClockTimeElapsed (ms): " + wallClockTimeElapsed / 1000000);

        System.out.println("result : " + result);

    }
}
