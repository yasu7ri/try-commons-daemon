package my.trials;

import org.apache.commons.daemon.Daemon;
import org.apache.commons.daemon.DaemonContext;
import org.apache.commons.daemon.DaemonInitException;

public class SampleDaemon implements Daemon {
    private Thread thread;
    private boolean stopped = false;

    @Override
    public void init(DaemonContext daemonContext) throws DaemonInitException, Exception {
        System.out.println("Daemon init.");
        thread = new Thread() {
            private long i = 0;

            @Override
            public void run() {
                while (!stopped) {
                    System.out.println(i++);
                    try {
                        sleep(1000);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        };
    }

    @Override
    public void start() throws Exception {
        System.out.println("Daemon start.");
        thread.start();
    }

    @Override
    public void stop() throws Exception {
        System.out.println("Daemon stop.");
        stopped = true;
        try {
            thread.join();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void destroy() {
        System.out.println("Daemon destroy.");
        thread = null;
    }
}
