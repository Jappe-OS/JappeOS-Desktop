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

library window_manager;

import 'dart:typed_data';

import 'package:event/event.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'package:flutter/material.dart';
import 'package:jappeos_desktop_ui/widgets/blur_container.dart';
import 'package:jappeos_desktop_ui/widgets/solid_container.dart';
import 'package:jappeos_desktop_ui/widgets/text.dart';

//
// Window manager base
part 'window.dart';
part 'window_stack.dart';
part 'window_stack_controller.dart';
part 'window_widgets.dart';
