require 'formula'

class Aria2 <Formula
  url 'http://downloads.sourceforge.net/project/aria2/stable/latest/aria2-1.9.1.tar.bz2'
  md5 '5dd66f1045b6ace7c1673cd0912d2d41'
  homepage 'http://aria2.sourceforge.net/'

  def install
    ENV.gcc_4_2 # 1.8.2 didn't work w/ LLVM on 10.6
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end

  def patches
    # Adds missing source file for 1.9.1.
    # See: http://sourceforge.net/apps/phpbb/aria2/viewtopic.php?f=2&t=48
    DATA
  end
end

__END__
diff -rupN a/src/timespec.h b/src/timespec.h
--- a/src/timespec.h	1969-12-31 19:00:00.000000000 -0500
+++ b/src/timespec.h	2010-04-23 12:49:36.000000000 -0400
@@ -0,0 +1,45 @@
+/*
+ * aria2 - The high speed download utility
+ *
+ * Copyright (C) 2010 Tatsuhiro Tsujikawa
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * In addition, as a special exception, the copyright holders give
+ * permission to link the code of portions of this program with the
+ * OpenSSL library under certain conditions as described in each
+ * individual source file, and distribute linked combinations
+ * including the two.
+ * You must obey the GNU General Public License in all respects
+ * for all of the code used other than OpenSSL.  If you modify
+ * file(s) with this exception, you may extend this exception to your
+ * version of the file(s), but you are not obligated to do so.  If you
+ * do not wish to do so, delete this exception statement from your
+ * version.  If you delete this exception statement from all source
+ * files in the program, then also delete it here.
+ */
+/* copyright --> */
+#ifndef _D_TIMESPEC_H_
+#define _D_TIMESPEC_H_
+
+#include "common.h"
+
+#include <time.h>
+
+#ifndef HAVE_STRUCT_TIMESPEC
+struct timespec { time_t tv_sec; long tv_nsec; };
+#endif // !HAVE_STRUCT_TIMESPEC
+
+#endif // _D_TIMESPEC_H_
