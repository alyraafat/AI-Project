package algo;

import java.util.HashSet;

public class WaterSortSearch extends GenericSearch{
    private String noSolution = "NOSOLUTION";
    public boolean goalFunc(Node n){
        for(WaterBottle wb: n.waterBottles){
            if (!wb.isSameColor) return false;
        }
        return true;
    }


    public String solve(String initialState, String strategy, boolean visualize){
        Node initNode = decodeInitString(initialState);
        QingFun qingFun = decodeStrategy(strategy);
        Node res = null;
        if(qingFun instanceof IDS){
            res = this.solveForIDS(initNode, (IDS) qingFun);
        }else{
            res = this.generalSearch(initNode, qingFun);
        }
//        System.out.println("here2");
        if (res == null) return this.noSolution;
        return encodeOutput(res);
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

    public QingFun decodeStrategy(String strategy){
        switch(strategy.toLowerCase()){
            case "df": return new DFS();
            case "uc": return new UCS();
            case "id": return new IDS();
            case "as1": return new AStar1();
            case "as2": return new AStar2();
            case "gr1": return new Greedy1();
            case "gr2": return new Greedy2();
            default: return new BFS();
        }
    }

    public String encodeOutput(Node node){
        int cost = node.cost;
        int nodesExpanded = this.nodesExpanded;
        String plan = node.path;
        return plan + ";" + cost + ";" + nodesExpanded;
    }

    public static void main(String[] args){
        String init = "5;4;" + "b,y,r,b;" + "b,y,r,r;" + "y,r,b,y;" + "e,e,e,e;" + "e,e,e,e;";
        String strategy = "ucs";
        WaterSortSearch ws = new WaterSortSearch();
        String out = ws.solve(init, strategy, false);
        System.out.println(out);
    }
}
