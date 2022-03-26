#!/bin/bash


GRADLE_HOME=/usr/share/java/gradle /usr/lib/jvm/java-17-openjdk/bin/java \
-Declipse.application=org.eclipse.jdt.ls.core.id1 \
-Dosgi.bundles.defaultStartLevel=4 \
-Declipse.product=org.eclipse.jdt.ls.core.product \
-Dlog.level=ALL -noverify \
-Xmx1G \
-jar /home/mkg/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar \
-configuration /home/mkg/.local/share/nvim/lsp_servers/jdtls/config_linux \
-data /home/mkg/coding/jdtls_workspaces \
--add-modules=ALL-SYSTEM \
--add-opens java.base/java.util=ALL-UNNAMED \
--add-opens java.base/java.lang=ALL-UNNAMED
