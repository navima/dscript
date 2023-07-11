import gq.nagy.dscript.DscriptLexer;
import gq.nagy.dscript.DscriptParser;
import org.antlr.v4.runtime.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.util.ArrayList;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class DScriptTest {
    @ParameterizedTest
    @MethodSource("testDataProvider")
    public void test(String in) {
        // only tests for really big errors, not actual AST correctness.
        var lexer = new DscriptLexer(CharStreams.fromString(in));
        var parser = new DscriptParser(new CommonTokenStream(lexer));
        var errors = new ArrayList<>();
        var listener = new BaseErrorListener() {
            @Override
            public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {
                errors.add(offendingSymbol);
                super.syntaxError(recognizer, offendingSymbol, line, charPositionInLine, msg, e);
            }
        };
        lexer.addErrorListener(listener);
        parser.addErrorListener(listener);

        // When
        parser.body();

        // Then
        assertTrue(errors.isEmpty());
    }

    public static Stream<Arguments> testDataProvider() {
        return Stream.of(
                "{0}valami{1}{2}  {3} {        4        } {\"\\{\"} som\\{eth\\}ing", // Test substitutions and escaping
                "A: {10} B: {10.2} C: {\"something~\"} D: {true} C: {false} D: {someConstant}", // Test literals
                "This is a (test... text) for operators {lastName + \" \" + firstName} {true && !false} {true || false} {56+9} {x+y} {x-y} {x/y} {x*y} .\n", // Test operators
                "escaping subs: \\{} \\#  {\"{}\"} {\"\\{}\"} \\##valami valaki (ujuj/9)\n",
                "more comple{\"X\"} test: {\"#<>\"}#bg field dark#name intro#spriteadd mc neutral 0#say mc"
        ).map(e -> () -> new Object[]{e});
    }
}
