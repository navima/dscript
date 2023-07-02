import gq.nagy.dscript.DscriptLexer;
import gq.nagy.dscript.DscriptParser;
import gq.nagy.dscript.DscriptParserBaseListener;
import gq.nagy.dscript.DscriptParserBaseVisitor;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ErrorNode;
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
        var parser = new DscriptParser(new CommonTokenStream(new DscriptLexer(CharStreams.fromString(in))));
        var errors = new ArrayList<>();
        var listener = new BaseErrorListener() {
            @Override
            public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {
                errors.add(offendingSymbol);
                super.syntaxError(recognizer, offendingSymbol, line, charPositionInLine, msg, e);
            }
        };
        new DscriptLexer(CharStreams.fromString(in)).addErrorListener(listener);
        parser.addErrorListener(listener);

        // When
        parser.body();

        // Then
        assertTrue(errors.isEmpty());
    }

    public static Stream<Arguments> testDataProvider() {
        return Stream.of(
                "This is a (test... text) for substitutions {lastName + \" \" + firstName} {true && false}.\n",
                "escaping subs: \\{} \\#  {\"{}\"} {\"\\{}\"} \\##valami valaki (ujuj/9)\n",
                "more comple{\"X\"} test: {\"#<>\"}#bg field dark#name intro#spriteadd mc neutral 0#say mc"
        ).map(e -> () -> new Object[]{e});
    }
}
