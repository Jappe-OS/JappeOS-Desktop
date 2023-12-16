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

library base;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jappeos_desktop/applications/widgetTesting/main.dart';
import 'package:jappeos_desktop/main.dart';
import 'package:jappeos_desktop/window_manager/window_manager.dart';
import 'package:jappeos_desktop_ui/jappeos_desktop_ui.dart';
import 'package:jappeos_desktop_ui/widgets/bases/button_base_glasshover.dart';
import 'package:jappeos_desktop_ui/widgets/blur_container.dart';
import 'package:jappeos_desktop_ui/widgets/context_menu.dart';
import 'package:jappeos_desktop_ui/widgets/text.dart';

import 'package:jappeos_desktop_ui/widgets/bases/button_base.dart';


//
// Base
part 'constants.dart';
part 'desktop.dart';
//
// Components
part 'components/desktop_widgets.dart';
//
// Menu Manager
part 'desktop_menu_manager/desktop_menu_controller.dart';
part 'desktop_menu_manager/menus/launcher_menu.dart';
part 'desktop_menu_manager/menus/search_menu.dart';
part 'desktop_menu_manager/menus/notification_menu.dart';
part 'desktop_menu_manager/menus/control_center_menu.dart';
part 'desktop_menu_manager/menus/permissions_menu.dart';