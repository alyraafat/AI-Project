package algo;

import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.lang.management.ThreadMXBean;
import com.sun.source.tree.Tree;

import java.util.HashSet;
import java.util.TreeSet;

public class WaterSortSearch extends GenericSearch{
    private String noSolution = "NOSOLUTION";
    
    
    public boolean goalFunc(Node n){
        for(WaterBottle wb: n.waterBottles){
            if (!wb.isSameColor) return false;
        }
        return true;
    }


    public static String solve(String initialState, String strategy, boolean visualize) throws Exception {
        WaterSortSearch problem = new WaterSortSearch();
    	Node initNode = problem.decodeInitString(initialState);
    	//System.out.println(stateToString(initNode));
        QingFun qingFun = problem.decodeStrategy(strategy);
        Node res = null;
        if(qingFun instanceof IDS){
            res = problem.solveForIDS(initNode, (IDS) qingFun);
        }else{
            res = problem.generalSearch(initNode, qingFun);
        }
//        System.out.println("here2");
        if (res == null) return problem.noSolution;
        if(visualize) System.out.println(visualizeSteps(res));;
        return problem.encodeOutput(res);
    }
    
    
    public static String visualizeSteps(Node node) {
    	if(node.parent == null) {
    		return stateToString(node);
    	}
    	
    	return visualizeSteps(node.parent) + "\n" + stateToString(node);
    }
    
    public static String stateToString(Node node) {
        String result = "";
        WaterBottle[] waterBottles = node.waterBottles;
        int bottleLength = waterBottles[0].capacity;
        result += node.operator != null? "After " + node.operator + "\n" : "Start" + "\n";
        for (int i = 0; i < bottleLength; i++) {
            for (int j = 0; j < waterBottles.length; j++) {
                String color = waterBottles[j].colors[i];
                result += " " + color + " |";  // Added space before color for alignment
            }
            result += "\n";
        }
        
        
        for (int k = 0; k < waterBottles.length; k++) {
            result += "--- "; 
        }
        result += "\n";
        
        for (int k = 0; k < waterBottles.length; k++) {
            result += " " + k + "  "; 
        }
        result += "\n" + "-----------------------------------------";
        return result;
    }

     
    public Node solveForIDS(Node initNode, IDS ids){
        for(int i=0; i<=ids.getMaxDepth(); i++){
            ids.setSeen(new HashSet<>());
            ids.setCurrDepth(i);
            Node res = this.generalSearch(initNode, ids);
            if (res != null) return res;
        }
        return null;
    }

    public Node decodeInitString(String initialState){
        String[] elems = initialState.split(";");
        int numberOfBottles = Integer.parseInt(elems[0]);
        int bottleCapacity = Integer.parseInt(elems[1]);
        WaterBottle[] wbs = new WaterBottle[numberOfBottles];
        for(int i=2; i<elems.length; i++){
            WaterBottle wb = new WaterBottle(elems[i], bottleCapacity, i-2);
            wbs[i-2] = wb;
        }
        return new Node(null, 0,0,null, wbs);
    }

    public QingFun decodeStrategy(String strategy) throws Exception {
        switch(strategy.toLowerCase()){
            case "bf" : return new BFS();
            case "df": return new DFS();
            case "uc": return new UCS();
            case "id": return new IDS();
            case "as1": return new AStar1();
            case "as2": return new AStar2();
            case "gr1": return new Greedy1();
            case "gr2": return new Greedy2();
            default: throw new Exception("Input a valid strategy [bf, df, uc, id, as1, as2, gr1, gr2]");
        }
    }

    public String encodeOutput(Node node){
        int cost = node.cost;
        int nodesExpanded = this.nodesExpanded;
        String plan = node.path;
        return plan + ";" + cost + ";" + nodesExpanded;
    }

    public static void main(String[] args) throws Exception {
        // Initialize variables
    	String grid0 = "3;" +
                "4;" +
                "r,y,r,y;" +
                "y,r,y,r;" +
                "e,e,e,e;";
        String grid1 = "5;" +
                "4;" +
                "b,y,r,b;" +
                "b,y,r,r;" +
                "y,r,b,y;" +
                "e,e,e,e;" +
                "e,e,e,e;";
        String grid2 = "5;" +
                "4;" +
                "b,r,o,b;" +
                "b,r,o,o;" +
                "r,o,b,r;" +
                "e,e,e,e;" +
                "e,e,e,e;";
        String grid3 = "6;" +
                "4;" +
                "g,g,g,r;" +
                "g,y,r,o;" +
                "o,r,o,y;" +
                "y,o,y,b;" +
                "r,b,b,b;" +
                "e,e,e,e;";
        String grid4 = "6;" +
                "3;" +
                "r,r,y;" +
                "b,y,r;" +
                "y,b,g;" +
                "g,g,b;" +
                "e,e,e;" +
                "e,e,e;";
        String strategy = "BF";

        // Get Runtime, OperatingSystemMXBean, and ThreadMXBean instances
        Runtime runtime = Runtime.getRuntime();
        ThreadMXBean threadBean = ManagementFactory.getThreadMXBean();

        // Calculate initial memory usage
        long startMemory = runtime.totalMemory() - runtime.freeMemory();

        // Record initial CPU time and wall-clock time
        long startCpuTime = threadBean.getCurrentThreadCpuTime();
        long startWallClockTime = System.nanoTime();

        // Call the solve method
        String solution = WaterSortSearch.solve(grid1, strategy, true);

        // Calculate final memory usage
        long endMemory = runtime.totalMemory() - runtime.freeMemory();
        long memoryUsed = endMemory - startMemory;

        // Record final CPU time and wall-clock time
        long endCpuTime = threadBean.getCurrentThreadCpuTime();
        long endWallClockTime = System.nanoTime();

        // Calculate CPU time used and wall-clock time
        long cpuTimeUsed = endCpuTime - startCpuTime;
        long wallClockTimeElapsed = endWallClockTime - startWallClockTime;

        // Calculate CPU Utilization as a percentage
        double cpuUtilization = (double) cpuTimeUsed / wallClockTimeElapsed * 100;

        // Print results
        System.out.println(solution);
        System.out.println("Memory used (MB): " + (memoryUsed / 100000));
        System.out.println("CPU utilization (%): " + cpuUtilization);
    }
}
