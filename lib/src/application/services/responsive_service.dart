import 'package:flutter/material.dart';

final class ResponsiveService {
  ResponsiveService(this.context);

  final BuildContext context;

  Breakpoints _getActiveBreakpoint() {
    final double screenSize = MediaQuery.sizeOf(context).width;
    final Breakpoints activeBreakpoint = _getCurrentBreakpoint(screenSize);
    return activeBreakpoint;
  }

  Breakpoints _getCurrentBreakpoint(double screenWidth) {
    if (screenWidth < Breakpoints.sm.value) {
      return Breakpoints.xs;
    }
    if (screenWidth < Breakpoints.md.value) {
      return Breakpoints.sm;
    }
    if (screenWidth < Breakpoints.lg.value) {
      return Breakpoints.md;
    }
    if (screenWidth < Breakpoints.xl.value) {
      return Breakpoints.lg;
    }
    return Breakpoints.xl;
  }

  ValueType value<ValueType>(
    Map<Breakpoints, ValueType> value,
  ) {
    final Breakpoints activeBreakpoint = _getActiveBreakpoint();
    return _resolveValueForBreakpoint(value, activeBreakpoint) as ValueType;
  }

  final Map<Breakpoints, double> _breakpointsOrderByBreakpoint = <Breakpoints, double>{
    Breakpoints.xs: 0,
    Breakpoints.sm: 1,
    Breakpoints.md: 2,
    Breakpoints.lg: 3,
    Breakpoints.xl: 4,
  };

  final Map<int, Breakpoints> _breakpointsOrderByOrder = <int, Breakpoints>{
    0: Breakpoints.xs,
    1: Breakpoints.sm,
    2: Breakpoints.md,
    3: Breakpoints.lg,
    4: Breakpoints.xl,
  };

  dynamic _resolveValueForBreakpoint(Map<Breakpoints, dynamic> value, Breakpoints activeBreakpoint) {
    if (value.containsKey(activeBreakpoint) && value[activeBreakpoint] != null) {
      return value[activeBreakpoint];
    }

    final double? currentBreakpointOrder = _breakpointsOrderByBreakpoint[activeBreakpoint];

    for (double? i = currentBreakpointOrder; i! >= 0; i--) {
      final Breakpoints? breakpoint = _breakpointsOrderByOrder[i];
      if (value.containsKey(breakpoint) && value[breakpoint] != null) {
        return value[breakpoint];
      }
    }
  }
}

enum Breakpoints {
  xs(320),
  sm(480),
  md(640),
  lg(960),
  xl(1200);

  const Breakpoints(this.value);

  final int value;
}
