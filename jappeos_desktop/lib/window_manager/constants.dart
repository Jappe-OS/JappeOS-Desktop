//  JappeOS-Desktop, The desktop environment for JappeOS.
//  Copyright (C) 2023  Jappe02
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Affero General Public License as
//  published by the Free Software Foundation, either version 3 of the
//  License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Affero General Public License for more details.
//
//  You should have received a copy of the GNU Affero General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

// ignore_for_file: constant_identifier_names

part of window_manager;

/// Reserved size (width and height) of windows control buttons (minimize, maximize/restore, close).
/// This is the size of all control buttons and their paddings added together.
/// Made to prevent control buttons from overlapping the windows body/
/// content in the client area of the window.
///
/// Mainly used for windows with custom client decorations aligned on the right
/// side of the window to prevent the decorations from going under the control buttons.
/// This may also be used with [CustomWindow]'s.
const WM_UI_WINDOW_RESERVED_CONTROL_BUTTONS_SIZE = Size(3 * (25 + 8) + 8, 35);
