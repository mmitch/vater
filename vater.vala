class Vater : GLib.Object {

	private static Gtk.Clipboard primary;
	private static Gtk.Clipboard clipboard;

	private static bool selectToClipboard() {
		var setting = GLib.Environment.get_variable ("VATER_SELECT_TO_CLIPBOARD") ?? "0";
		return setting == "1";
	}

	private static void writeToClipboard(Gtk.Clipboard from, string? text) {
		if (text == null) {
			return;
		}
		clipboard.set_text (text, -1);
	}

	private static void copySelectionToClipboard(Vte.Terminal terminal) {
		primary.request_text (writeToClipboard);
	}

	private static double byteToDouble(uint byte) {
		return byte / 255.0;
	}

	private static Gdk.RGBA rgb(uint r, uint g, uint b) {
		return { byteToDouble (r), byteToDouble (g), byteToDouble (b), 0 };
	}

	private static void setColors(Vte.Terminal terminal) {
		Gdk.RGBA[] palette = {
			rgb( 0x00, 0x00, 0x00 ),
			rgb( 0xd0, 0x00, 0x00 ),
			rgb( 0x00, 0xd0, 0x00 ),
			rgb( 0xd0, 0xd0, 0x00 ),
			rgb( 0x70, 0x70, 0xd0 ),
			rgb( 0xd0, 0x00, 0xd0 ),
			rgb( 0x00, 0xd0, 0xd0 ),
			rgb( 0xd0, 0xd0, 0xd0 ),
			rgb( 0x80, 0x80, 0x80 ),
			rgb( 0xf0, 0x00, 0x00 ),
			rgb( 0x00, 0xf0, 0x00 ),
			rgb( 0xf0, 0xf0, 0x00 ),
			rgb( 0x80, 0x80, 0xf0 ),
			rgb( 0xf0, 0x00, 0xf0 ),
			rgb( 0x00, 0xf0, 0xf0 ),
			rgb( 0xf0, 0xf0, 0xf0 ),
		};

		terminal.set_colors (null, null, palette);
		terminal.set_bold_is_bright (true);
	}

	private static void setFont(Vte.Terminal terminal) {
		var font = GLib.Environment.get_variable ("VATER_FONT") ?? "Noto Mono 11";
		terminal.set_font (Pango.FontDescription.from_string ( font ) );
	}

	private static void setWordSelection(Vte.Terminal terminal) {
		terminal.set_word_char_exceptions ( "-/@_&.:?=" );
	}

	public static int main(string[] args) {
		/* Initialise GTK, and the window */
		Gtk.init (ref args);
		var terminal = new Vte.Terminal ();
		var win = new Gtk.Window ();
		win.set_title ("vater");
		
		/* Start a new shell */
		var command = GLib.Environment.get_variable ("SHELL");
		try {
			terminal.spawn_sync (
				Vte.PtyFlags.DEFAULT,
				null,    /* working directory */
				new string[] { command }, /* command */
				null,    /* additional environment */
				0,       /* spawn flags */
				null,    /* child setup */
				null     /* child pid */
				);
		} catch (GLib.Error e) {
			stderr.printf ("Error: %s\n", e.message);
			return 1;
		}
		
		/* individualization */
		setColors (terminal);
		setFont (terminal);
		setWordSelection (terminal);

		/* Connect some signals */
		win.destroy.connect (Gtk.main_quit);
		terminal.child_exited.connect (Gtk.main_quit);
		if (selectToClipboard()) {
			primary   = Gtk.Clipboard.get (Gdk.SELECTION_PRIMARY  );
			clipboard = Gtk.Clipboard.get (Gdk.SELECTION_CLIPBOARD);
			terminal.selection_changed.connect (copySelectionToClipboard);
		}
		
		/* Put widgets together and run the main loop */
		win.add (terminal);
		win.show_all ();
		Gtk.main ();
		
		return 0;
	}
}
